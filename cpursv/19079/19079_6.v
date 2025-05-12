
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16+(0-1):0] Ax;
  input  [16+(0-1):0] Ay;
  input  [16+(0-1):0] Az;
  input  [(0-1)+46:0] Bx;
  input  [(0-1)+46:0] By;
  input  [(0-1)+46:0] Bz;
  output [46+(16+1):0] C;
  reg  [46+(16+1):0] C;
  input  clk;
  reg  [(16+(0-1))+46:0] AxBx;
  reg  [(16+(0-1))+46:0] AyBy;
  reg  [(16+(0-1))+46:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= {AxBx[(16+(0-1))+46],AxBx[(16+(0-1))+46],AxBx}+({AzBz[(16+(0-1))+46],AzBz[(16+(0-1))+46],AzBz}+{AyBy[(16+(0-1))+46],AyBy[(16+(0-1))+46],AyBy});
      end
endmodule

