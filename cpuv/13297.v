module flagtester (busADD, busA, busB, carryOut, zADD, oADD, cADD, nADD); 
	output reg [31:0] busADD; 
	output reg [31:0] busA, busB; 
	output reg carryOut; 
	input zADD, oADD, cADD, nADD; 
	parameter d = 20; 
	initial 
	begin
		$display("busADD \t busA \t busB \t carryOut \t zADD \t oADD \t cADD \t nADD \t "); 
		#d; 
	end
	reg [31:0] i; 
	initial 
	begin
		$monitor("%b \t %b \t %b \t %b \t %b \t %b \t %b", busADD, busA, busB, zADD, oADD, cADD, nADD, $time); 
		busADD = 32'h02020202; busA = 32'h01010101; busB = 32'h01010101; carryOut = 1'b0; 
		#(3*d); 
		busADD = 32'h010100FE; busA = 32'h01010101; busB = 32'hFFFFFFFD; carryOut = 1'b1; 
		#(3*d); 
		busADD = 32'h01010100; busA = 32'hFFFF0101; busB = 32'h0101FFFF; carryOut = 1'b1; 
		#(3*d); 
		busADD = 32'hFFFFBBBA; busA = 32'hFFFFFFFF; busB = 32'hFFFFBBBB; carryOut = 1'b1; 
		#(3*d); 
		busADD = 32'hEFFFBBBA; busA = 32'h7FFFFFFF; busB = 32'h7FFFBBBB; carryOut = 1'b0; 
		#(3*d); 
		$stop; 
		$finish; 
	end
endmodule 