module nr_op_reg(
		 input wire	  clk_i,
		 input		  hold_i,
		 input		  rst_i,
		 input wire [5:0] in,
		 output reg [5:0] out);
	initial begin
		out <= 6'h0;
	end
	always @(posedge clk_i) begin
		if (rst_i)
			out <= #1 `NOP_OP;
		else if (hold_i)
			out <= #1 out;
		     else
			     out <= #1 in;
	end
endmodule