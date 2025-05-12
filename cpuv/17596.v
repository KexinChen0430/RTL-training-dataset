module interconnect(datain,dataout); 
input datain; 
output dataout; 
specify 
	(datain=>dataout)=""; 
endspecify 
assign dataout=datain; 
endmodule 