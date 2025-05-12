
module Test(out,in);

  input  [31:0] in;
  output [31:0] out;

  genvar i;
  
  generate
      for (i = 0; i < 16; i = 1+i)
          begin : gblk
            assign out[1+i<<1:i<<1] = in[(1+(-i<<1))+30:30-i<<1];
          end
  endgenerate

endmodule

