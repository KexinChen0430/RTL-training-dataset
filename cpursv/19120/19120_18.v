
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16+(0-1):0] Ax;
  input  [16+(0-1):0] Ay;
  input  [16+(0-1):0] Az;
  input  [16+(0-1):0] Bx;
  input  [16+(0-1):0] By;
  input  [16+(0-1):0] Bz;
  output [16<<<1:0] Cx;
  reg  [16<<<1:0] Cx;
  output [16<<<1:0] Cy;
  reg  [16<<<1:0] Cy;
  output [16<<<1:0] Cz;
  reg  [16<<<1:0] Cz;
  input  clk;
  reg  [16+(16+(0-1)):0] AyBz;
  reg  [16+(16+(0-1)):0] AzBy;
  reg  [16+(16+(0-1)):0] AzBx;
  reg  [16+(16+(0-1)):0] AxBz;
  reg  [16+(16+(0-1)):0] AxBy;
  reg  [16+(16+(0-1)):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Bz*Ay;
        AzBy <= By*Az;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= Ax*By;
        AyBx <= Bx*Ay;
        Cx <= {AyBz[16+(16+(0-1))],AyBz}-{AzBy[16+(16+(0-1))],AzBy};
        Cy <= {AzBx[16+(16+(0-1))],AzBx}-{AxBz[16+(16+(0-1))],AxBz};
        Cz <= {AxBy[16+(16+(0-1))],AxBy}+(-{AyBx[16+(16+(0-1))],AyBx});
      end
endmodule

