module outputs) 
   wire [n*INWIDTH  +: INWIDTH] ins;		
   wire [n*INWIDTH  +: INWIDTH] ins2;		
   wire [n*INWIDTH  +: INWIDTH] ins3;		
   wire [n*OUTWIDTH +: OUTWIDTH] outs;		
   wire [n*OUTWIDTH +: OUTWIDTH] outs2;		
   wire [4*OUTWIDTH-1 : 0] outs3;		
   genvar i; 
   generate 
      for (i=0; i<4; i=i+1) begin 
	 InstMod instName ( 
			   .ins			(ins [n*INWIDTH  +: INWIDTH]), 
			   .outs		(outs[n*OUTWIDTH +: OUTWIDTH])); 
	 InstMod instName2 
	     (
	      .ins    (ins2 [n*INWIDTH  +: INWIDTH]), 
	      .outs   (outs2[n*OUTWIDTH +: OUTWIDTH]) 
	      ); 
	 InstMod instName3 
	     (
	      .ins    (ins3 [n*INWIDTH  +: INWIDTH]), 
	      .outs   (outs3[n*OUTWIDTH +: OUTWIDTH]) 
`ifdef NEVER
	      .ins    (ins3 [4*INWIDTH-1  : 0]), 
	      .outs   (outs3[4*OUTWIDTH-1 : 0]) 
`endif
	      ); 
      end 
   endgenerate 
endmodule 