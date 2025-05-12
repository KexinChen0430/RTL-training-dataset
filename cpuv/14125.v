module hdr */ 
always @(*) begin
   out_ctrl_next                 = out_ctrl; 
   out_data_next                 = out_data; 
   out_wr_next                   = 0; 
   state_next                    = state; 
   dram_fifo_read_next           = 1'b0; 
   accum_value_fifo_rdreq_next   = 1'b0; 
   flushed_keys_next             = flushed_keys; 
   interpkt_gap_counter_next     = interpkt_gap_counter; 
   words_per_packet_cnt_next     = words_per_packet_cnt; 
   word_sel_next                 = word_sel; 
   tx_ext_update_rdreq_next      = 1'b0; 
   case(state)
     WAIT_DATA: begin
         if(!accum_value_fifo_empty) begin 
             state_next = SEND_TCHECK_NETFPGA_HDR;
         end
     end
     SEND_PUT_NETFPGA_HDR: begin
        if(out_rdy) begin 
           out_wr_next   = 1;
           out_data_next = put_netfpga_header; 
           out_ctrl_next = 8'hFF; 
           state_next    = SEND_PUT_HDR; 
           word_sel_next = 0; 
        end
     end
     SEND_PUT_HDR: begin
        if(out_rdy) begin 
           out_wr_next   = 1'b1;
           out_data_next = put_header[word_sel]; 
           out_ctrl_next = 8'h00; 
           word_sel_next = word_sel+1; 
           if(word_sel==(MAX_WORDS_IN_PUT_HEADER-1)) begin 
               tx_ext_update_rdreq_next = 1'b1; 
               state_next = READ_PUT_WORD; 
               words_per_packet_cnt_next = words_per_packet_cnt+1; 
           end
           else begin
               tx_ext_update_rdreq_next = 1'b0; 
               state_next = SEND_PUT_HDR; 
           end
        end
     end
     READ_PUT_WORD: begin
         state_next = SEND_PUT_PKT; 
     end
     SEND_PUT_PKT: begin
        if(out_rdy) begin 
           out_wr_next             = 1;
           out_data_next           = {key_little,val_little}; 
           if(words_per_packet_cnt==MAX_WORDS_PER_PACKET) begin 
                out_ctrl_next       = 8'h80; 
                state_next          = INTERPKT_GAP; 
                words_per_packet_cnt_next = 0; 
                interpkt_gap_counter_next = interpkt_gap_cycles; 
           end
           else begin
                words_per_packet_cnt_next = words_per_packet_cnt+1; 
                tx_ext_update_rdreq_next  = 1'b1; 
                state_next                = READ_PUT_WORD; 
                out_ctrl_next             = 8'h00; 
           end
        end
     end
     INTERPKT_GAP:begin
         if(interpkt_gap_counter==0)
             state_next = WAIT_DATA; 
         else
             interpkt_gap_counter_next = interpkt_gap_counter-1; 
     end
     FLUSH_DATA:begin
         if((interpkt_gap_counter==0) && (!dram_fifo_empty))
             state_next = SEND_FLUSH_NETFPGA_HDR; 
         else
             interpkt_gap_counter_next = interpkt_gap_counter-1; 
     end
     SEND_FLUSH_NETFPGA_HDR: begin
        if(out_rdy) begin 
           out_wr_next   = 1;
           out_data_next = flush_netfpga_header; 
           out_ctrl_next = 8'hFF; 
           state_next    = SEND_FLUSH_HDR; 
           word_sel_next = 0; 
        end
     end
     SEND_FLUSH_HDR:begin
        if(out_rdy) begin 
           out_wr_next   = 1;
           out_data_next = flush_header[word_sel]; 
           out_ctrl_next = 8'h00; 
           if(word_sel==(MAX_WORDS_IN_HEADER-1)) begin 
               state_next = READ_DRAM_WORD; 
               dram_fifo_read_next = 1'b1; 
           end
           else begin
               state_next = SEND_FLUSH_HDR; 
           end
           word_sel_next = word_sel+1; 
        end
     end
     READ_DRAM_WORD:begin
         state_next = SEND_FLUSH_PKT; 
     end
     SEND_FLUSH_PKT: begin
        if(out_rdy) begin 
              out_wr_next     = 1;
              out_data_next   = dram_fifo_readdata; 
              out_ctrl_next   = 8'h80; 
              if((flushed_keys==(num_keys-1))) begin 
                  state_next = WAIT_DATA; 
                  flushed_keys_next = 0; 
              end
              else begin
                  state_next = FLUSH_DATA; 
                  flushed_keys_next = flushed_keys+1; 
                  interpkt_gap_counter_next = interpkt_gap_cycles; 
              end
        end
     end
     SEND_TCHECK_NETFPGA_HDR: begin
        if(out_rdy) begin 
           out_wr_next   = 1;
           out_data_next = tcheck_netfpga_header; 
           out_ctrl_next = 8'hFF; 
           state_next    = SEND_TCHECK_HDR; 
           word_sel_next = 0; 
        end
     end
     SEND_TCHECK_HDR:begin
        if(out_rdy) begin 
           out_wr_next   = 1;
           out_data_next = tcheck_header[word_sel]; 
           out_ctrl_next = 8'h00; 
           if(word_sel==(MAX_WORDS_IN_HEADER-1)) begin 
               state_next = READ_ACCUMULATE_WORD; 
               accum_value_fifo_rdreq_next = 1'b1; 
           end
           else begin
               state_next = SEND_TCHECK_HDR; 
           end
           word_sel_next = word_sel+1; 
        end
     end
     READ_ACCUMULATE_WORD:begin
         state_next = SEND_TCHECK_PKT; 
     end
     SEND_TCHECK_PKT: begin
        if(out_rdy) begin 
              out_wr_next     = 1;
              out_data_next   = {32'h0,accum_value_fifo_dataout}; 
              out_ctrl_next   = 8'h80; 
              state_next      = WAIT_DATA; 
        end
     end
   endcase 
end 
always @(posedge clk) begin
   if(reset) begin 
      state                    <= WAIT_DATA;
      out_data                 <= 0;
      out_ctrl                 <= 1;
      out_wr                   <= 0;
      flushed_keys             <= 0;
      interpkt_gap_counter     <= 0;
      tx_ext_update_rdreq      <= 0;
      words_per_packet_cnt     <= 0;
      word_sel                 <= 0;
      dram_fifo_read           <= 0;
      accum_value_fifo_rdreq   <= 0;
   end
   else begin 
      state                    <= state_next;
      out_data                 <= out_data_next;
      out_ctrl                 <= out_ctrl_next;
      out_wr                   <= out_wr_next;
      flushed_keys             <= flushed_keys_next;
      interpkt_gap_counter     <= interpkt_gap_counter_next;
      words_per_packet_cnt     <= words_per_packet_cnt_next;
      word_sel                 <= word_sel_next;
      tx_ext_update_rdreq      <= tx_ext_update_rdreq_next;
      dram_fifo_read           <= dram_fifo_read_next;
      accum_value_fifo_rdreq   <= accum_value_fifo_rdreq_next;
   end 
end 
endmodule 