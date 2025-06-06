
module bgfill(clk,hsync,vsync,r,g,b);

  input  clk,hsync,vsync;
  output r,g,b;
  reg  ff1,ff2;

  
  always @(negedge clk)
      begin
        if (vsync) ff1 <= ~ff1;
        else ff1 <= 0;
      end
  
  always @(negedge hsync)
      begin
        if (vsync) ff2 <= ~ff2;
        else ff2 <= 0;
      end
  assign r = ~((((((ff1 & ((ff2 | ff1) & ~ff2)) & ~ff1) | (ff2 & ~ff1)) | (~ff1 | ff1)) & ((((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1) & ((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))))) ^ (((((ff1 & ((ff2 | ff1) & ~ff2)) & ~ff1) | (ff2 & ~ff1)) | (~ff1 | ff1)) & ((ff2 & (((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1)) & (((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1)))) & 1'b0;
  assign g = (1'b0 & (((((ff1 & ((ff2 | ff1) & ~ff2)) & ~ff1) | (ff2 & ~ff1)) | (((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1)) & (ff2 & (((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1)))) ^ (1'b0 & (((((ff1 & ((ff2 | ff1) & ~ff2)) & ~ff1) | (ff2 & ~ff1)) | (((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2))) | ~ff1)) & ((ff1 & ~ff1) | (ff1 & ((ff2 | ff1) & ~ff2)))));
  assign b = (((~ff1 | ff1) & (1'b1 & ff1)) & (~ff2 | (ff2 & (~ff1 & 1'b1)))) ^ (((ff2 & 1'b1) & (~ff1 | ff1)) & (~ff2 | (ff2 & (~ff1 & 1'b1))));
endmodule

