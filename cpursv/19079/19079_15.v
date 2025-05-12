
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+16:0] Ax;
  input  [(0-1)+16:0] Ay;
  input  [(0-1)+16:0] Az;
  input  [46+(0-1):0] Bx;
  input  [46+(0-1):0] By;
  input  [46+(0-1):0] Bz;
  output [16+(46+1):0] C;
  reg  [16+(46+1):0] C;
  input  clk;
  reg  [((0-1)+16)+46:0] AxBx;
  reg  [((0-1)+16)+46:0] AyBy;
  reg  [((0-1)+16)+46:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AzBz[((0-1)+16)+46],AzBz[((0-1)+16)+46],AzBz}+{AyBy[((0-1)+16)+46],AyBy[((0-1)+16)+46],AyBy})+{AxBx[((0-1)+16)+46],AxBx[((0-1)+16)+46],AxBx};
      end
endmodule

