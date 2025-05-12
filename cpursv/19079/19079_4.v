
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [46-1:0] Bx;
  input  [46-1:0] By;
  input  [46-1:0] Bz;
  output [46+(1+16):0] C;
  reg  [46+(1+16):0] C;
  input  clk;
  reg  [46+((-1)+16):0] AxBx;
  reg  [46+((-1)+16):0] AyBy;
  reg  [46+((-1)+16):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= By*Ay;
        AzBz <= Az*Bz;
        C <= {AyBy[46+((-1)+16)],AyBy[46+((-1)+16)],AyBy}+({AxBx[46+((-1)+16)],AxBx[46+((-1)+16)],AxBx}+{AzBz[46+((-1)+16)],AzBz[46+((-1)+16)],AzBz});
      end
endmodule

