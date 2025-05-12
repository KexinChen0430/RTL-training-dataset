module LAG_ctrl_reg (ctrl_in, ctrl_out, clk, rst_n); 
   input     chan_cntrl_t ctrl_in; 
   output    chan_cntrl_t ctrl_out; 
   input     clk, rst_n; 
   always@(posedge clk) begin
      if (!rst_n) begin
         ctrl_out <= '0; 
      end else begin
         ctrl_out <= ctrl_in; 
      end
   end
endmodule 