
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16+(-1):0] Ax;
  input  [16+(-1):0] Ay;
  input  [16+(-1):0] Az;
  input  [33+(-1):0] Bx;
  input  [33+(-1):0] By;
  input  [33+(-1):0] Bz;
  output [(33+1)+16:0] C;
  reg  [(33+1)+16:0] C;
  input  clk;
  reg  [(33+(-1))+16:0] AxBx;
  reg  [(33+(-1))+16:0] AyBy;
  reg  [(33+(-1))+16:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= {AxBx[(33+(-1))+16],AxBx[(33+(-1))+16],AxBx}+({AzBz[(33+(-1))+16],AzBz[(33+(-1))+16],AzBz}+{AyBy[(33+(-1))+16],AyBy[(33+(-1))+16],AyBy});
      end
endmodule

