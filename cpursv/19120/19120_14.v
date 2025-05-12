
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16+(0-1):0] Ax;
  input  [16+(0-1):0] Ay;
  input  [16+(0-1):0] Az;
  input  [16+(0-1):0] Bx;
  input  [16+(0-1):0] By;
  input  [16+(0-1):0] Bz;
  output [16+16:0] Cx;
  reg  [16+16:0] Cx;
  output [16+16:0] Cy;
  reg  [16+16:0] Cy;
  output [16+16:0] Cz;
  reg  [16+16:0] Cz;
  input  clk;
  reg  [(0-1)+(16+16):0] AyBz;
  reg  [(0-1)+(16+16):0] AzBy;
  reg  [(0-1)+(16+16):0] AzBx;
  reg  [(0-1)+(16+16):0] AxBz;
  reg  [(0-1)+(16+16):0] AxBy;
  reg  [(0-1)+(16+16):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Bz*Ay;
        AzBy <= Az*By;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= Ax*By;
        AyBx <= Ay*Bx;
        Cx <= {AyBz[(0-1)+(16+16)],AyBz}-{AzBy[(0-1)+(16+16)],AzBy};
        Cy <= {AzBx[(0-1)+(16+16)],AzBx}-{AxBz[(0-1)+(16+16)],AxBz};
        Cz <= {AxBy[(0-1)+(16+16)],AxBy}+(0-{AyBx[(0-1)+(16+16)],AyBx});
      end
endmodule

