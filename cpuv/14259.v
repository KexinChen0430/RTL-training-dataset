module bug461; 
   generate 
      genvar  g;  
      begin : topgen 
	 genvar  g2; 
	 genvar  g1; 
	 for (g=0; g<100; g++) begin end 
	 for (g=0; g<100; g++) begin end 
      end 
      for (g=0; g<100; g++) begin end 
   endgenerate 
endmodule 