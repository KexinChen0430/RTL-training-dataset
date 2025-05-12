module MX4 (
	input D0, 
	input D1, 
	input D2, 
	input D3, 
	input S0, 
	input S1, 
	output Y  
);
	assign Y = S1 ? (S0 ? D3 : D2) 
	           : (S0 ? D1 : D0);   
endmodule 