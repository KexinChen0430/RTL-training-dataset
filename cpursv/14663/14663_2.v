
module GENERIC_IOB  #(parameter 
       INPUT_USED  = 1'b0,
       OUTPUT_USED = 1'b0,
       ENABLE_USED = 1'b0)
  (inout  PAD,
   input  I,EN,
   output O);

  
  generate
      if (ENABLE_USED && OUTPUT_USED) assign PAD = EN ? I : 1'bz;
      else if (OUTPUT_USED) assign PAD = I;
        
  endgenerate

  
  generate
      if (INPUT_USED) assign O = PAD;
        
  endgenerate

endmodule

