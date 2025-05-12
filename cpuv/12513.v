module float_div ( 
	clock, 
	dataa, 
	datab, 
	division_by_zero, 
	overflow, 
	result) 
; 
input	  clock; 
input	[31:0]  dataa; 
input	[31:0]  datab; 
output	  division_by_zero; 
output	  overflow; 
output	[31:0]  result; 
endmodule 