module nr_reg(
	      input wire	  clk_i,
	      input		  hold_i,
	      input		  rst_i,
	      input wire [`N-1:0] in,
	      output reg [`N-1:0] out);
	initial begin
		out <= `N'h0;
	end
	always @(posedge clk_i) begin
		if (rst_i)
			out <= #1 `N'h0;
		else if (hold_i)
			out <= #1 out;
		     else
			     out <= #1 in;
	end
endmodule