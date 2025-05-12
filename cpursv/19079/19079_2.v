
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+16:0] Ax;
  input  [(0-1)+16:0] Ay;
  input  [(0-1)+16:0] Az;
  input  [(0-1)+46:0] Bx;
  input  [(0-1)+46:0] By;
  input  [(0-1)+46:0] Bz;
  output [46+(1+16):0] C;
  reg  [46+(1+16):0] C;
  input  clk;
  reg  [16+((0-1)+46):0] AxBx;
  reg  [16+((0-1)+46):0] AyBy;
  reg  [16+((0-1)+46):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AxBx[16+((0-1)+46)],AxBx[16+((0-1)+46)],AxBx}+{AyBy[16+((0-1)+46)],AyBy[16+((0-1)+46)],AyBy})+{AzBz[16+((0-1)+46)],AzBz[16+((0-1)+46)],AzBz};
      end
endmodule

