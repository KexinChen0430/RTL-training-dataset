module clock_unit(output reg clk);
	initial begin
		clk = 0; 
		#10 
		forever #10 clk = ~clk; 
	end
endmodule 