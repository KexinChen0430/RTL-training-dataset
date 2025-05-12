
module shifter_32b  #(parameter  LENGTH = 1)
  (input  clk,
   input  [31:0] val_in,
   output [31:0] val_out);

  
  generate
      reg  [(LENGTH*32)+(-1):0] r;

      
      always @(posedge clk)      r <= val_in | r<<<32;
      assign val_out = r[(LENGTH*32)+(-1):(LENGTH-1)*32];
  endgenerate

endmodule

