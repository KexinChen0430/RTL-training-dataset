module header and move the packet 
   always @(*) begin 
      out_ctrl = in_fifo_ctrl_dout; 
      out_data = in_fifo_data_dout; 
      state_next = state; 
      out_wr = 0; 
      in_fifo_rd_en = 0; 
      dst_port_rd = 0; 
      case(state) 
        WAIT_TILL_DONE_DECODE: begin 
           if(!dst_port_fifo_empty) begin 
              dst_port_rd     = 1; 
              state_next      = WRITE_HDR; 
              in_fifo_rd_en   = 1; 
           end
        end
        WRITE_HDR: begin 
           if(out_rdy) begin 
              if(in_fifo_ctrl_dout==`IO_QUEUE_STAGE_NUM) begin 
                 out_data[`IOQ_DST_PORT_POS + NUM_OUTPUT_QUEUES - 1:`IOQ_DST_PORT_POS] = dst_ports_latched; 
              end
              out_wr          = 1; 
              in_fifo_rd_en   = 1; 
              state_next      = SKIP_HDRS; 
           end
        end
        SKIP_HDRS: begin 
           if(in_fifo_ctrl_dout==0) begin 
              state_next = WAIT_EOP; 
           end
           if(!in_fifo_empty & out_rdy) begin 
              in_fifo_rd_en   = 1; 
              out_wr          = 1; 
           end
        end
        WAIT_EOP: begin 
           if(in_fifo_ctrl_dout!=0)begin 
              if(out_rdy) begin 
                 state_next   = WAIT_TILL_DONE_DECODE; 
                 out_wr       = 1; 
              end
           end
           else if(!in_fifo_empty & out_rdy) begin 
              in_fifo_rd_en   = 1; 
              out_wr          = 1; 
           end
        end 
      endcase 
   end 
   always @(posedge clk) begin 
      if(reset) begin 
         state <= WAIT_TILL_DONE_DECODE; 
      end
      else begin
         state <= state_next; 
      end
   end
endmodule 