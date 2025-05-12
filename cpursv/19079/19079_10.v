
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+46:0] Bx;
  input  [(-1)+46:0] By;
  input  [(-1)+46:0] Bz;
  output [16+(1+46):0] C;
  reg  [16+(1+46):0] C;
  input  clk;
  reg  [((-1)+16)+46:0] AxBx;
  reg  [((-1)+16)+46:0] AyBy;
  reg  [((-1)+16)+46:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= {AxBx[((-1)+16)+46],AxBx[((-1)+16)+46],AxBx}+({AzBz[((-1)+16)+46],AzBz[((-1)+16)+46],AzBz}+{AyBy[((-1)+16)+46],AyBy[((-1)+16)+46],AyBy});
      end
endmodule

