
module dotproduct16x46(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [46-1:0] Bx;
  input  [46-1:0] By;
  input  [46-1:0] Bz;
  output [1+(16+46):0] C;
  reg  [1+(16+46):0] C;
  input  clk;
  reg  [(16+46)-1:0] AxBx;
  reg  [(16+46)-1:0] AyBy;
  reg  [(16+46)-1:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= ({AyBy[(16+46)-1],AyBy[(16+46)-1],AyBy}+{AxBx[(16+46)-1],AxBx[(16+46)-1],AxBx})+{AzBz[(16+46)-1],AzBz[(16+46)-1],AzBz};
      end
endmodule

