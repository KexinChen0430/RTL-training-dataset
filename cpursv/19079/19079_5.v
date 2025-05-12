
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+46:0] Bx;
  input  [(-1)+46:0] By;
  input  [(-1)+46:0] Bz;
  output [(46+1)+16:0] C;
  reg  [(46+1)+16:0] C;
  input  clk;
  reg  [(-1)+(46+16):0] AxBx;
  reg  [(-1)+(46+16):0] AyBy;
  reg  [(-1)+(46+16):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= {AyBy[(-1)+(46+16)],AyBy[(-1)+(46+16)],AyBy}+({AxBx[(-1)+(46+16)],AxBx[(-1)+(46+16)],AxBx}+{AzBz[(-1)+(46+16)],AzBz[(-1)+(46+16)],AzBz});
      end
endmodule

