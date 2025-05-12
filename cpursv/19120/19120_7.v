
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+16:0] Bx;
  input  [(-1)+16:0] By;
  input  [(-1)+16:0] Bz;
  output [16<<<1:0] Cx;
  reg  [16<<<1:0] Cx;
  output [16<<<1:0] Cy;
  reg  [16<<<1:0] Cy;
  output [16<<<1:0] Cz;
  reg  [16<<<1:0] Cz;
  input  clk;
  reg  [16+((-1)+16):0] AyBz;
  reg  [16+((-1)+16):0] AzBy;
  reg  [16+((-1)+16):0] AzBx;
  reg  [16+((-1)+16):0] AxBz;
  reg  [16+((-1)+16):0] AxBy;
  reg  [16+((-1)+16):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Ay*Bz;
        AzBy <= By*Az;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= Ax*By;
        AyBx <= Ay*Bx;
        Cx <= (0-{AzBy[16+((-1)+16)],AzBy})+{AyBz[16+((-1)+16)],AyBz};
        Cy <= (0-{AxBz[16+((-1)+16)],AxBz})+{AzBx[16+((-1)+16)],AzBx};
        Cz <= (-{AyBx[16+((-1)+16)],AyBx})+{AxBy[16+((-1)+16)],AxBy};
      end
endmodule

