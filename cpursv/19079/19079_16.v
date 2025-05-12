
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [46+(0-1):0] Bx;
  input  [46+(0-1):0] By;
  input  [46+(0-1):0] Bz;
  output [(16+46)+1:0] C;
  reg  [(16+46)+1:0] C;
  input  clk;
  reg  [(46+(0-1))+16:0] AxBx;
  reg  [(46+(0-1))+16:0] AyBy;
  reg  [(46+(0-1))+16:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Az*Bz;
        C <= ({AyBy[(46+(0-1))+16],AyBy[(46+(0-1))+16],AyBy}+{AxBx[(46+(0-1))+16],AxBx[(46+(0-1))+16],AxBx})+{AzBz[(46+(0-1))+16],AzBz[(46+(0-1))+16],AzBz};
      end
endmodule

