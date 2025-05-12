
module jcsablock(Y,carryout,A,B,carryin);

  output [3:0] Y;
  output carryout;
  input  [3:0] A,B;
  input  carryin;
  wire [3:0] g,p;
  wire [4:0] c;

  assign c[0] = carryin;
  genvar i;
  for (i = 0; i <= 3; i = i+1)
      begin
        assign p[i] = (((B[i] | (~B[i] & A[i])) & ~B[i]) | ~A[i]) & (B[i] | (~B[i] & A[i]));
        assign c[i+1] = (c[i] & ((c[i] | B[i]) & (B[i] | (~B[i] & A[i])))) | (((c[i] | B[i]) & (B[i] | (~B[i] & A[i]))) & A[i]);
        assign Y[i] = c[i] ^ ((((B[i] | (~B[i] & A[i])) & ~B[i]) | ~A[i]) & (B[i] | (~B[i] & A[i])));
      end
  assign z = (p[1] & (p[0] & p[2])) & p[3];
  assign carryout = z ? carryin : c[4];
endmodule

