module MUX_ARRAY(O,B_R,A,B,sel,clk); 
	parameter m=163; 
	input wire[0:m-1] A,B; 
	output wire[0:m-1] O,B_R; 
	input wire sel,clk; 
	wire[0:m-1] temp; 
	MUX mu[0:m-1](O,A,B,sel); 
	assign B_R = O; 
endmodule 