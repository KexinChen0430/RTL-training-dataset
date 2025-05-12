module hdr */ 
   always @(*) begin 
      out_ctrl_next                 = in_fifo_ctrl; 
      out_data_next                 = in_fifo_data; 
      out_wr_next                   = 0; 
      rd_preprocess_info            = 0; 
      state_next                    = state; 
      in_fifo_rd_en                 = 0; 
      to_from_cpu_next              = to_from_cpu; 
      dst_port_next                 = dst_port; 
      pkt_sent_from_cpu             = 0; 
      pkt_sent_to_cpu_options_ver   = 0; 
      pkt_sent_to_cpu_arp_miss      = 0; 
      pkt_sent_to_cpu_lpm_miss      = 0; 
      pkt_sent_to_cpu_bad_ttl       = 0; 
      pkt_forwarded                 = 0; 
      pkt_dropped_checksum          = 0; 
      pkt_sent_to_cpu_non_ip        = 0; 
      pkt_dropped_wrong_dst_mac     = 0; 
      pkt_sent_to_cpu_dest_ip_hit   = 0; 
      case(state) 
        WAIT_PREPROCESS_RDY: begin 
           if(preprocess_vld) begin 
              else if(is_for_us && (input_port_num==mac_dst_port_num || is_broadcast)) begin 
                 if(is_ip_pkt) begin 
                    if(ip_checksum_is_good) begin 
                       /* if the packet has any options or ver!=4 or the TTL is 1 or 0 or if the ip destination address 
                       if(dest_ip_hit || (ip_hdr_has_options | !ip_ttl_is_good | !arp_lookup_hit | !lpm_lookup_hit)) begin 
                          rd_preprocess_info            = 1; 
                          to_from_cpu_next              = 1; 
                          dst_port_next                 = to_cpu_output_port; 
                          state_next                    = MOVE_MODULE_HDRS; 
                          pkt_sent_to_cpu_dest_ip_hit   = dest_ip_hit; 
                          pkt_sent_to_cpu_bad_ttl       = !ip_ttl_is_good & !dest_ip_hit; 
                          pkt_sent_to_cpu_options_ver   = ip_hdr_has_options & 
                                                          ip_ttl_is_good & !dest_ip_hit;
                          pkt_sent_to_cpu_lpm_miss      = !lpm_lookup_hit & !ip_hdr_has_options & 
                                                          ip_ttl_is_good & !dest_ip_hit;
                          pkt_sent_to_cpu_arp_miss      = !arp_lookup_hit & lpm_lookup_hit & 
                                                          !ip_hdr_has_options & ip_ttl_is_good &
                                                          !dest_ip_hit;
                       end
                       else if (!is_broadcast) begin 
                          to_from_cpu_next   = 0; 
                          dst_port_next      = output_port; 
                          state_next         = MOVE_MODULE_HDRS; 
                          pkt_forwarded      = 1; 
                       end 
                       else begin 
                          pkt_dropped_wrong_dst_mac   = 1; 
                          rd_preprocess_info          = 1; 
                          in_fifo_rd_en               = 1; 
                          state_next                  = DROP_PKT; 
                       end
                    end 
                    else begin 
                       pkt_dropped_checksum   = 1; 
                       rd_preprocess_info     = 1; 
                       in_fifo_rd_en          = 1; 
                       state_next             = DROP_PKT; 
                    end 
                 end 
                 else begin 
                    pkt_sent_to_cpu_non_ip   = 1; 
                    rd_preprocess_info       = 1; 
                    to_from_cpu_next         = 1; 
                    dst_port_next            = to_cpu_output_port; 
                    state_next               = MOVE_MODULE_HDRS; 
                 end 
              end 
              else begin 
                 pkt_dropped_wrong_dst_mac   = 1; 
                 rd_preprocess_info          = 1; 
                 in_fifo_rd_en               = 1; 
                 state_next                  = DROP_PKT; 
              end 
           end 
        end 
        MOVE_MODULE_HDRS: begin 
           if(out_rdy & in_fifo_vld) begin 
              out_wr_next      = 1; 
              in_fifo_rd_en    = 1; 
              if (in_fifo_ctrl == IOQ_STAGE_NUM) begin 
                 out_data_next = {{(DATA_WIDTH-NUM_QUEUES-`IOQ_DST_PORT_POS){1'b0}}, dst_port, in_fifo_data[`IOQ_DST_PORT_POS-1:0]}; 
                 if (to_from_cpu) 
                    state_next = MOVE_PKT; 
              end
              else if(in_fifo_ctrl==0) begin 
                 out_data_next = {next_hop_mac, src_mac_sel[47:32]}; 
                 state_next    = SEND_SRC_MAC_LO; 
              end
              else begin 
                 out_data_next = in_fifo_data; 
              end
           end
        end 
        SEND_SRC_MAC_LO: begin 
           if(out_rdy && in_fifo_vld) begin 
              out_wr_next     = 1; 
              in_fifo_rd_en   = 1; 
              out_data_next   = {src_mac_sel[31:0], in_fifo_data[31:0]}; 
              state_next      = SEND_IP_TTL; 
           end
        end
        SEND_IP_TTL: begin 
           if(out_rdy && in_fifo_vld) begin 
              out_wr_next     = 1; 
              in_fifo_rd_en   = 1; 
              out_data_next   = {in_fifo_data[63:16], ip_new_ttl[7:0], in_fifo_data[7:0]}; 
              state_next      = SEND_IP_CHECKSUM; 
           end
        end
        SEND_IP_CHECKSUM: begin 
           if(out_rdy && in_fifo_vld) begin 
              out_wr_next          = 1; 
              in_fifo_rd_en        = 1; 
              out_data_next        = {ip_new_checksum, in_fifo_data[47:0]}; 
              rd_preprocess_info   = 1; 
              state_next           = MOVE_PKT; 
           end
        end
        MOVE_PKT: begin 
           if(out_rdy && in_fifo_vld) begin 
              out_wr_next     = 1; 
              in_fifo_rd_en   = 1; 
              out_data_next   = in_fifo_data; 
              if(eop) begin 
                 state_next   = WAIT_PREPROCESS_RDY; 
              end
           end
        end 
        DROP_PKT: begin 
           if(in_fifo_vld) begin 
              in_fifo_rd_en = 1; 
              if(eop) begin 
                 state_next = WAIT_PREPROCESS_RDY; 
              end
           end
        end
      endcase 
   end 
   always @(posedge clk) begin 
      if(reset) begin 
         state             <= WAIT_PREPROCESS_RDY; 
         out_data          <= 0; 
         out_ctrl          <= 1; 
         out_wr            <= 0; 
         ctrl_prev_is_0    <= 0; 
         to_from_cpu       <= 0; 
         dst_port          <= 'h0; 
      end
      else begin 
         state             <= state_next; 
         out_data          <= out_data_next; 
         out_ctrl          <= out_ctrl_next; 
         out_wr            <= out_wr_next; 
         ctrl_prev_is_0    <= in_fifo_rd_en ? (in_fifo_ctrl==0) : ctrl_prev_is_0; 
         to_from_cpu       <= to_from_cpu_next; 
         dst_port          <= dst_port_next; 
      end 
   end 
endmodule 