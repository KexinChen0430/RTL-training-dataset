module when:
   always @(posedge clk)
   begin
      if (reset || cnet_reprog)
      begin
         wr_data_rdy <= 1'b0;
         wr_pci_done <= 1'b0;
         wr_dma_done <= 1'b0;
      end
      else
      begin
         if (dma_data_vld && !xfer_is_rd)
            wr_data_rdy <= (non_aligned_bytes == 2'b00) || !first_word_pci;
         else if (wr_data_rdy || wr_pci_done)
            wr_data_rdy <= wr_pci_done && !wr_dma_done &&
                           (!wr_data_rdy || !last_word_to_wr_fifo);
         if (dma_data_vld && !xfer_is_rd)
            wr_pci_done <= last_word_pci;
         if (dma_data_vld && !xfer_is_rd || wr_data_rdy)
            wr_dma_done <= last_word_to_wr_fifo || (wr_dma_done && wr_data_rdy);
      end
   end
   always @(posedge clk)
   begin
      if (reset || cnet_reprog)
      begin
         rdb_data_avail <= 1'b0;
         rd_cnet_done <= 1'b0;
      end
      else
      begin
         if (rdb_wr_en || rd_data_rdy)
            case (non_aligned_bytes)
               2'b01 : rd_realign_buf <= {rd_realign_buf[23:0], dma_data_frm_cnet_swapped};
               2'b10 : rd_realign_buf <= {rd_realign_buf[23:8], dma_data_frm_cnet_swapped, 8'b0};
               2'b11 : rd_realign_buf <= {rd_realign_buf[23:16], dma_data_frm_cnet_swapped, 16'b0};
               default : rd_realign_buf <= {dma_data_frm_cnet_swapped, 24'b0};
            endcase
         if (rdb_wr_en)
            rdb_data_avail <= 1'b1;
         else if (rd_data_rdy)
            rdb_data_avail <= rd_cnet_done && !rd_fifo_done &&
                              (!rdb_data_avail || !last_word_to_rd_fifo);
         if (rdb_wr_en)
            rd_cnet_done <= last_word_from_cnet;
         if (rdb_wr_en || rd_data_rdy)
            rd_fifo_done <= last_word_to_rd_fifo || (rd_data_rdy && rd_fifo_done);
      end
   end
   always @*
   begin
      case (non_aligned_bytes)
         2'b00    : wr_buf_data_swapped <= wr_realign_buf[31:0];
         2'b01    : wr_buf_data_swapped <= wr_realign_buf[39:8];
         2'b10    : wr_buf_data_swapped <= wr_realign_buf[47:16];
         default  : wr_buf_data_swapped <= wr_realign_buf[55:24];
      endcase
   end
   assign wr_buf_data = {wr_buf_data_swapped[7:0],
                         wr_buf_data_swapped[15:8],
                         wr_buf_data_swapped[23:16],
                         wr_buf_data_swapped[31:24]};
   always @*
      rd_buf_data_swapped <= rd_realign_buf[55:24];
   assign rd_buf_data = host_is_le ?
                        {rd_buf_data_swapped[7:0],
                         rd_buf_data_swapped[15:8],
                         rd_buf_data_swapped[23:16],
                         rd_buf_data_swapped[31:24]} :
                        rd_buf_data_swapped;
   assign dma_data_frm_cnet_swapped = {
                  dma_data_frm_cnet[7:0],
                  dma_data_frm_cnet[15:8],
                  dma_data_frm_cnet[23:16],
                  dma_data_frm_cnet[31:24]
                  };
   always @(posedge clk)
   begin
      if (reset || cnet_reprog)
         to_wr_fifo_cnt <= 'h0;
      else if (ld_xfer_cnt)
         to_wr_fifo_cnt <= to_cnet_cnt_start;
      else if (wr_data_rdy)
         to_wr_fifo_cnt <= to_wr_fifo_cnt - 'h1;
   end
   always @(posedge clk)
   begin
      if (reset || cnet_reprog)
         to_rd_fifo_cnt <= 'h0;
      else if (ld_xfer_cnt)
         to_rd_fifo_cnt <= xfer_cnt_start;
      else if (rd_data_rdy)
         to_rd_fifo_cnt <= to_rd_fifo_cnt - 'h1;
   end
   assign last_word_to_wr_fifo = to_wr_fifo_cnt == 'h1;
   assign last_word_to_rd_fifo = to_rd_fifo_cnt == 'h1;
   always @(posedge clk)
   begin
      if (reset || cnet_reprog)
         data_frm_cnet_ready <= 1'b0;
      else if (dma_rd_en)
         data_frm_cnet_ready <= 1'b1;
      else if (rd_data_rdy || discard)
         data_frm_cnet_ready <= 1'b0;
   end
   assign rdb_wr_en = data_frm_cnet_ready && !discard && !rd_full;
   assign read_from_cnet = rdb_wr_en;
   assign rd_data_rdy = rdb_data_avail && !rd_full;
   assign dma_rd_en = !dma_empty &&
                      (!data_frm_cnet_ready || discard || rdb_wr_en);
endmodule