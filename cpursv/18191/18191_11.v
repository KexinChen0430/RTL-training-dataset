
module Test(out,in);

  input  [31:0] in;
  output [31:0] out;

  genvar i;
  
  generate
      for (i = 0; i < 16; i = i+1)
          begin : gblk
            assign out[i<<1+1:i<<1] = in[(30-i<<1)+1:30-i<<1];
          end
  endgenerate

endmodule

