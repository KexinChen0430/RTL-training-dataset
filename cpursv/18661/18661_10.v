
module shifter_32b  #(parameter  LENGTH = 1)
  (input  clk,
   input  [31:0] val_in,
   output [31:0] val_out);

  
  generate
      reg  [(32*LENGTH)-1:0] r;

      
      always @(posedge clk)
          r <= val_in | ((2**32)*r);
      assign val_out = r[(32*LENGTH)-1:(LENGTH+(0-1))*32];
  endgenerate

endmodule

