
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
        assign p[i] = (B[i] | A[i]) & (~B[i] | ~A[i]);
        assign c[1+i] = (A[i] | c[i]) & (((c[i] | B[i]) & A[i]) | B[i]);
        assign Y[i] = (c[i] & (~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i])) | (((((c[i] | ((B[i] | A[i]) & (~B[i] | ~A[i]))) & (~c[i] | ((c[i] | B[i]) & (A[i] | c[i])))) & ((~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i]) & ((A[i] & (~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i])) & ~c[i]))) & (~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i])) ^ ((~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i]) & (((c[i] | ((B[i] | A[i]) & (~B[i] | ~A[i]))) & (~c[i] | ((c[i] | B[i]) & (A[i] | c[i])))) & ((~c[i] & ((~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i]) & B[i])) & (~((B[i] | A[i]) & (~B[i] | ~A[i])) | ~c[i])))));
      end
  assign z = p[0] & ((p[1] & p[3]) & p[2]);
  assign carryout = z ? carryin : c[4];
endmodule

