module bug403_bug404; 
   (* attr *) wire foo; 
   always @ (*) begin end 
   always @ (*
	     ) begin end 
endmodule 