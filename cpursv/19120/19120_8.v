
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+16:0] Bx;
  input  [(-1)+16:0] By;
  input  [(-1)+16:0] Bz;
  output [1<<1*16:0] Cx;
  reg  [1<<1*16:0] Cx;
  output [1<<1*16:0] Cy;
  reg  [1<<1*16:0] Cy;
  output [1<<1*16:0] Cz;
  reg  [1<<1*16:0] Cz;
  input  clk;
  reg  [(1<<1*16)+(-1):0] AyBz;
  reg  [(1<<1*16)+(-1):0] AzBy;
  reg  [(1<<1*16)+(-1):0] AzBx;
  reg  [(1<<1*16)+(-1):0] AxBz;
  reg  [(1<<1*16)+(-1):0] AxBy;
  reg  [(1<<1*16)+(-1):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Ay*Bz;
        AzBy <= By*Az;
        AzBx <= Az*Bx;
        AxBz <= Ax*Bz;
        AxBy <= By*Ax;
        AyBx <= Bx*Ay;
        Cx <= {AyBz[(1<<1*16)+(-1)],AyBz}-{AzBy[(1<<1*16)+(-1)],AzBy};
        Cy <= (-{AxBz[(1<<1*16)+(-1)],AxBz})+{AzBx[(1<<1*16)+(-1)],AzBx};
        Cz <= {AxBy[(1<<1*16)+(-1)],AxBy}-{AyBx[(1<<1*16)+(-1)],AyBx};
      end
endmodule

