module \$ff #( 
	parameter integer WIDTH = 1 
) (
	input [WIDTH-1:0] D, 
	output reg [WIDTH-1:0] Q 
);
	wire sysclk = testbench.sysclk; 
	always @(posedge sysclk)
		Q <= D; 
endmodule