assign cur_queue_plus1 = (cur_queue == NUM_QUEUES-1) ? 0 : cur_queue + 1;
assign fifo_out_ctrl_sel = fifo_out_ctrl[cur_queue];
assign fifo_out_data_sel = fifo_out_data[cur_queue];
always @(*) begin
   state_next = state;
   cur_queue_next = cur_queue;
   fifo_out_ctrl_prev_next = fifo_out_ctrl_prev;
   out_wr_next = 0;
   out_ctrl_next = fifo_out_ctrl_sel;
   out_data_next = fifo_out_data_sel;
   rd_en = 0;
   eop = 0;
   case(state)
     IDLE: begin
        if(!empty[cur_queue] && out_rdy) begin
           state_next = WR_PKT;
           rd_en[cur_queue] = 1;
           fifo_out_ctrl_prev_next = STAGE_NUMBER;
        }
        if(empty[cur_queue] && out_rdy) begin
           cur_queue_next = cur_queue_plus1;
        end
     end
     WR_PKT: begin
        if(out_rdy & |fifo_out_ctrl_sel & (fifo_out_ctrl_prev==0) ) begin
           out_wr_next = 1;
           state_next = IDLE;
           cur_queue_next = cur_queue_plus1;
           eop = 1;
        }
        else if (out_rdy & !empty[cur_queue]) begin
           fifo_out_ctrl_prev_next = fifo_out_ctrl_sel;
           out_wr_next = 1;
           rd_en[cur_queue] = 1;
        end
     end 
   endcase 
end 
always @(posedge clk) begin
   if(reset) begin
      state <= IDLE;
      cur_queue <= 0;
      fifo_out_ctrl_prev <= 1;
      out_wr <= 0;
      out_ctrl <= 1;
      out_data <= 0;
   end
   else begin
      state <= state_next;
      cur_queue <= cur_queue_next;
      fifo_out_ctrl_prev <= fifo_out_ctrl_prev_next;
      out_wr <= out_wr_next;
      out_ctrl <= out_ctrl_next;
      out_data <= out_data_next;
   end
end
endmodule