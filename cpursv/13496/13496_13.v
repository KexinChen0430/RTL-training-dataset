
module jcsablock(Y,carryout,A,B,carryin);

  output [3:0] Y;
  output carryout;
  input  [3:0] A,B;
  input  carryin;
  wire [3:0] g,p;
  wire [4:0] c;

  assign c[0] = carryin;
  genvar i;
  for (i = 0; i <= 3; i = 1+i)
      begin
        assign p[i] = (~A[i] & B[i]) | (A[i] & (~A[i] | (~B[i] & ((A[i] & ~B[i]) | B[i]))));
        assign c[1+i] = (c[i] & ((A[i] & ~B[i]) | B[i])) | ((A[i] | (B[i] & c[i])) & B[i]);
        assign Y[i] = (~((~A[i] & B[i]) | (A[i] & (~A[i] | (~B[i] & ((A[i] & ~B[i]) | B[i]))))) | ~c[i]) & (((~c[i] & (~A[i] | (~B[i] & ((A[i] & ~B[i]) | B[i])))) | c[i]) & (c[i] | ((A[i] & ~B[i]) | B[i])));
      end
  assign z = (p[2] & (p[0] & p[3])) & p[1];
  assign carryout = z ? carryin : c[4];
endmodule

