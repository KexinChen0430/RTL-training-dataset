
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16+(-1):0] Ax;
  input  [16+(-1):0] Ay;
  input  [16+(-1):0] Az;
  input  [(-1)+33:0] Bx;
  input  [(-1)+33:0] By;
  input  [(-1)+33:0] Bz;
  output [1+(33+16):0] C;
  reg  [1+(33+16):0] C;
  input  clk;
  reg  [(33+16)+(-1):0] AxBx;
  reg  [(33+16)+(-1):0] AyBy;
  reg  [(33+16)+(-1):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AyBy[(33+16)+(-1)],AyBy[(33+16)+(-1)],AyBy}+({AzBz[(33+16)+(-1)],AzBz[(33+16)+(-1)],AzBz}+{AxBx[(33+16)+(-1)],AxBx[(33+16)+(-1)],AxBx});
      end
endmodule

