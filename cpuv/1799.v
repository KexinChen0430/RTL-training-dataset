module test_gen
  #( parameter
     SIZE = `MAX_SIZE, 
     MASK = `MAX_SIZE'b0) 
 (
   clk 
   );
   input clk; 
   generate
      genvar g; 
      for (g = 0; g < `MAX_SIZE; g = g + 1) begin 
         if ((g < (SIZE + 1)) && MASK[g]) begin
            always @(posedge clk) begin
`ifdef TEST_VERBOSE
               $write ("Logical AND generate if MASK [%1d] = %d\n", g, MASK[g]);
`endif
            end
         end
      end
   endgenerate
   generate
      for (g = 0; g < `MAX_SIZE; g = g + 1) begin 
         if ((g < SIZE) && MASK[g + 1]) begin
            always @(posedge clk) begin
`ifdef TEST_VERBOSE
               $write ("Logical AND generate if MASK [%1d] = %d\n", g, MASK[g]);
`endif
            end
         end
      end
   endgenerate
   generate
      for (g = 0; g < `MAX_SIZE; g = g + 1) begin 
         if ((g < (SIZE)) & MASK[g]) begin
            always @(posedge clk) begin
`ifdef TEST_VERBOSE
               $write ("Bitwise AND generate if MASK [%1d] = %d\n", g, MASK[g]);
`endif
            end
         end
      end
   endgenerate
   generate
      for (g = 0; g < `MAX_SIZE; g = g + 1) begin 
         if (!((g >= SIZE) | ~MASK[g])) begin
            always @(posedge clk) begin
`ifdef TEST_VERBOSE
               $write ("Bitwise OR generate if MASK [%1d] = %d\n", g, MASK[g]);
`endif
            end
         end
      end
   endgenerate
endmodule