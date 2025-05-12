
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [46-1:0] Bx;
  input  [46-1:0] By;
  input  [46-1:0] Bz;
  output [16+(46+1):0] C;
  reg  [16+(46+1):0] C;
  input  clk;
  reg  [(16-1)+46:0] AxBx;
  reg  [(16-1)+46:0] AyBy;
  reg  [(16-1)+46:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AxBx[(16-1)+46],AxBx[(16-1)+46],AxBx}+({AyBy[(16-1)+46],AyBy[(16-1)+46],AyBy}+{AzBz[(16-1)+46],AzBz[(16-1)+46],AzBz});
      end
endmodule

