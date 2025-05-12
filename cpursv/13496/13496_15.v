
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
        assign p[i] = B[i] ^ A[i];
        assign c[i+1] = ((B[i] & c[i]) | (B[i] & (A[i] & (c[i] | B[i])))) | ((B[i] | (A[i] & (c[i] | B[i]))) & c[i]);
        assign Y[i] = (B[i] ^ A[i]) ^ c[i];
      end
  assign z = ((p[0] & p[3]) & p[2]) & p[1];
  assign carryout = z ? carryin : c[4];
endmodule

