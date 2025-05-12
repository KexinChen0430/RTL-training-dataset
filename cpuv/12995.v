module subtracttester (busADD, busA, busB, zADD, oADD, cADD, nADD);
	input [31:0] busADD;
	output reg  [31:0] busA, busB;
	input zADD, oADD, cADD, nADD;
	parameter d = 20;
	initial 
	begin
		$display("busADD \t busA \t busB \t\t zADD \t oADD \t cADD \t nADD \t ");
		#d; 
	end
	reg [31:0] i;
	initial 
	begin
		$monitor("%b \t %b \t %b \t %b \t %b \t %b \t %b", busADD, busA, busB, zADD, oADD, cADD, nADD, $time);
		busA = 32'h01010101; busB = 32'h01010101;
		#d; 
		busA = 32'h7FFFFFF0; busB = 32'h7FFFFFFF;
		#d; 
		busA = 32'h00000001; busB = 32'hFFFFFFFF;
		#d; 
		busA = 32'h70000000; busB = 32'hF0000000;
		#d; 
		busA = 32'hFFFFFFFF; busB = 32'h00000001;
		#d; 
		busA = 32'h90000000; busB = 32'h70000000;
		#d; 
		busA = 32'hFFFFFFFF; busB = 32'hFFFFFFFF;
		#d; 
		busA = 32'hF0000000; busB = 32'hF0000000;
		#d; 
		#(3*d);
		$stop; 
		$finish; 
	end
endmodule