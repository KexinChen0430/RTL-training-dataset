
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [33-1:0] Bx;
  input  [33-1:0] By;
  input  [33-1:0] Bz;
  output [(33+16)+1:0] C;
  reg  [(33+16)+1:0] C;
  input  clk;
  reg  [16+(33-1):0] AxBx;
  reg  [16+(33-1):0] AyBy;
  reg  [16+(33-1):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= {AzBz[16+(33-1)],AzBz[16+(33-1)],AzBz}+({AyBy[16+(33-1)],AyBy[16+(33-1)],AyBy}+{AxBx[16+(33-1)],AxBx[16+(33-1)],AxBx});
      end
endmodule

