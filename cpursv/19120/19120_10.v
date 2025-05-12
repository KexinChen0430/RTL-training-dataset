
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [16-1:0] Bx;
  input  [16-1:0] By;
  input  [16-1:0] Bz;
  output [2*16:0] Cx;
  reg  [2*16:0] Cx;
  output [2*16:0] Cy;
  reg  [2*16:0] Cy;
  output [2*16:0] Cz;
  reg  [2*16:0] Cz;
  input  clk;
  reg  [(2*16)+(-1):0] AyBz;
  reg  [(2*16)+(-1):0] AzBy;
  reg  [(2*16)+(-1):0] AzBx;
  reg  [(2*16)+(-1):0] AxBz;
  reg  [(2*16)+(-1):0] AxBy;
  reg  [(2*16)+(-1):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Bz*Ay;
        AzBy <= Az*By;
        AzBx <= Az*Bx;
        AxBz <= Ax*Bz;
        AxBy <= By*Ax;
        AyBx <= Ay*Bx;
        Cx <= {AyBz[(2*16)+(-1)],AyBz}-{AzBy[(2*16)+(-1)],AzBy};
        Cy <= {AzBx[(2*16)+(-1)],AzBx}+(0-{AxBz[(2*16)+(-1)],AxBz});
        Cz <= {AxBy[(2*16)+(-1)],AxBy}-{AyBx[(2*16)+(-1)],AyBx};
      end
endmodule

