module multa 
(
	a,			 
	b,			 
	r			 
);
input	[`COEFWIDTH-2:0]			a; 
input	[`DATAWIDTH+2:0]			b; 
output	[`DATAWIDTH + `COEFWIDTH + 1:0]	r; 
assign r = a*b; 
endmodule 