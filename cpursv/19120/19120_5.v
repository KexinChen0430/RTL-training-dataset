
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16+(-1):0] Ax;
  input  [16+(-1):0] Ay;
  input  [16+(-1):0] Az;
  input  [16+(-1):0] Bx;
  input  [16+(-1):0] By;
  input  [16+(-1):0] Bz;
  output [16+16:0] Cx;
  reg  [16+16:0] Cx;
  output [16+16:0] Cy;
  reg  [16+16:0] Cy;
  output [16+16:0] Cz;
  reg  [16+16:0] Cz;
  input  clk;
  reg  [(16+16)-1:0] AyBz;
  reg  [(16+16)-1:0] AzBy;
  reg  [(16+16)-1:0] AzBx;
  reg  [(16+16)-1:0] AxBz;
  reg  [(16+16)-1:0] AxBy;
  reg  [(16+16)-1:0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Ay*Bz;
        AzBy <= By*Az;
        AzBx <= Az*Bx;
        AxBz <= Ax*Bz;
        AxBy <= By*Ax;
        AyBx <= Bx*Ay;
        Cx <= (-{AzBy[(16+16)-1],AzBy})+{AyBz[(16+16)-1],AyBz};
        Cy <= (-{AxBz[(16+16)-1],AxBz})+{AzBx[(16+16)-1],AzBx};
        Cz <= (0-{AyBx[(16+16)-1],AyBx})+{AxBy[(16+16)-1],AxBy};
      end
endmodule

