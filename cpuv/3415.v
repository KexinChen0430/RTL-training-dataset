module LAG_data_reg (data_in, data_out, clk, rst_n); 
   input     flit_t data_in; 
   output    flit_t data_out; 
   input     clk, rst_n; 
   always@(posedge clk) begin
      if (!rst_n) begin
	 data_out <= '0; 
      end else begin
	 data_out <= data_in; 
      end
   end
endmodule 