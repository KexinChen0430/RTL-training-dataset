module multiply_a (norma, normb, prod, twoormore); 
  input	 [`WSIG:0]		norma, normb;	
  output [`PRODWIDTH-1:0] 	prod;		
  output			twoormore;	
  assign prod		= norma * normb; 
  assign twoormore	= prod[`PRODWIDTH-1]; 
endmodule 