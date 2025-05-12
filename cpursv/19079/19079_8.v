
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [46+(0-1):0] Bx;
  input  [46+(0-1):0] By;
  input  [46+(0-1):0] Bz;
  output [1+(16+46):0] C;
  reg  [1+(16+46):0] C;
  input  clk;
  reg  [(16-1)+46:0] AxBx;
  reg  [(16-1)+46:0] AyBy;
  reg  [(16-1)+46:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AzBz[(16-1)+46],AzBz[(16-1)+46],AzBz}+{AyBy[(16-1)+46],AyBy[(16-1)+46],AyBy})+{AxBx[(16-1)+46],AxBx[(16-1)+46],AxBx};
      end
endmodule

