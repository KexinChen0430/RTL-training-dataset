module colonslash; 
   always @* 
     case (cond&4'b1110) 
       'h0:
	 t = 7; 
       'h2: 
	     t = 6; 
       'h4: t = 5; 
     endcase 
endmodule 