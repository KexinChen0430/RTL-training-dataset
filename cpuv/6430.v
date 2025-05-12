module hb_pll ( 
	inclk0, 
	pllena, 
	areset, 
	c0, 
	c1, 
	c2, 
	locked); 
input	  inclk0; 
input	  pllena; 
input	  areset; 
output	  c0; 
output	  c1; 
output	  c2; 
output	  locked; 
endmodule 