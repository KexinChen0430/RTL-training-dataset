
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [33+(-1):0] Bx;
  input  [33+(-1):0] By;
  input  [33+(-1):0] Bz;
  output [(33+1)+16:0] C;
  reg  [(33+1)+16:0] C;
  input  clk;
  reg  [((-1)+16)+33:0] AxBx;
  reg  [((-1)+16)+33:0] AyBy;
  reg  [((-1)+16)+33:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Az*Bz;
        C <= ({AyBy[((-1)+16)+33],AyBy[((-1)+16)+33],AyBy}+{AxBx[((-1)+16)+33],AxBx[((-1)+16)+33],AxBx})+{AzBz[((-1)+16)+33],AzBz[((-1)+16)+33],AzBz};
      end
endmodule

