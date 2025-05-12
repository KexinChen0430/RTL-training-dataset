module normalize(prod, normalized, tiny, twoormore); 
  input  [`PRODWIDTH-1:0]	prod;		
  output [`PRODWIDTH-1:0]	normalized;	
  input				tiny;		
  input				twoormore;	
  assign normalized = (tiny & twoormore) ? prod[`PRODWIDTH-1:0] : 
			((tiny ^ twoormore) ? {prod[`PRODWIDTH-2:0],1'b0} : 
			{prod[`PRODWIDTH-3:0],2'b0}); 
endmodule 