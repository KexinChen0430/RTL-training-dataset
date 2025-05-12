module bidirbuf ( 
	datain, 
	oe, 
	dataio, 
	dataout) 
; 
input	[15:0]  datain; 
input	[15:0]  oe; 
inout	[15:0]  dataio; 
output	[15:0]  dataout; 
endmodule 