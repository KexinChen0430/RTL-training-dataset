
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16+(-1):0] Ax;
  input  [16+(-1):0] Ay;
  input  [16+(-1):0] Az;
  input  [16+(-1):0] Bx;
  input  [16+(-1):0] By;
  input  [16+(-1):0] Bz;
  output [16<<<1:0] Cx;
  reg  [16<<<1:0] Cx;
  output [16<<<1:0] Cy;
  reg  [16<<<1:0] Cy;
  output [16<<<1:0] Cz;
  reg  [16<<<1:0] Cz;
  input  clk;
  reg  [16<<<1-1:0] AyBz;
  reg  [16<<<1-1:0] AzBy;
  reg  [16<<<1-1:0] AzBx;
  reg  [16<<<1-1:0] AxBz;
  reg  [16<<<1-1:0] AxBy;
  reg  [16<<<1-1:0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Bz*Ay;
        AzBy <= Az*By;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= By*Ax;
        AyBx <= Ay*Bx;
        Cx <= (0-{AzBy[16<<<1-1],AzBy})+{AyBz[16<<<1-1],AyBz};
        Cy <= {AzBx[16<<<1-1],AzBx}+(0-{AxBz[16<<<1-1],AxBz});
        Cz <= (-{AyBx[16<<<1-1],AyBx})+{AxBy[16<<<1-1],AxBy};
      end
endmodule

