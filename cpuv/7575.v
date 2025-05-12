module jt51_exprom 
(
	input [4:0] addr, 
	input clk, 
	output reg [44:0] exp 
);
	reg [44:0] explut[31:0]; 
	initial 
	begin
	explut[0] = 45'b111110101011010110001011010000010010111011011;
	explut[31] = 45'b010111010010110101000001100001001100000000011;
	end
	always @ (posedge clk) 
		exp <= explut[addr]; 
endmodule