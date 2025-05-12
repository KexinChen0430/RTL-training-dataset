module DIV27_19 ( 
	clock, 
	denom, 
	numer, 
	quotient, 
	remain); 
input	  clock; 
input	[34:0]  denom; 
input	[42:0]  numer; 
output	[42:0]  quotient; 
output	[34:0]  remain; 
endmodule 