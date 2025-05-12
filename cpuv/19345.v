module test_gen
  #( parameter
     SIZE = `MAX_SIZE, 
     MASK = `MAX_SIZE'b0) 
 (
   clk 
   );
   input clk; 
   generate
      if ((SIZE < 8'h04) && MASK[0]) begin
	 always @(posedge clk) begin
`ifdef TEST_VERBOSE
	    $write ("Generate IF MASK[0] = %d\n", MASK[0]);
`endif
	 end
      end
   endgenerate
endmodule