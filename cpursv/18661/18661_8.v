
module shifter_32b  #(parameter  LENGTH = 1)
  (input  clk,
   input  [31:0] val_in,
   output [31:0] val_out);

  
  generate
      reg  [(LENGTH*32)+(0-1):0] r;

      
      always @(posedge clk)      r <= r<<32 | val_in;
      assign val_out = r[(LENGTH*32)+(0-1):32*(LENGTH+(0-1))];
  endgenerate

endmodule

