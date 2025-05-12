module float_cmp ( 
	clk_en, 
	clock, 
	dataa, 
	datab, 
	ageb, 
	aleb) 
; 
input	  clk_en; 
input	  clock; 
input	[31:0]  dataa; 
input	[31:0]  datab; 
output	  ageb; 
output	  aleb; 
endmodule 