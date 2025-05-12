module test (
	     res,
	     clk,
	     in
   );
   output [1:0]  res; 
   input 	 clk; 
   input 	 in; 
   generate 
      genvar i; 
      for (i=0; i<2; i=i+1) begin 
	 always @(posedge clk) begin 
	    unique0 case (i) 
		      0: res[0:0] <= in; 
		      1: res[1:1] <= in; 
		    endcase
	 end
      end
   endgenerate 
endmodule 