
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+16:0] Bx;
  input  [(-1)+16:0] By;
  input  [(-1)+16:0] Bz;
  output [16*2:0] Cx;
  reg  [16*2:0] Cx;
  output [16*2:0] Cy;
  reg  [16*2:0] Cy;
  output [16*2:0] Cz;
  reg  [16*2:0] Cz;
  input  clk;
  reg  [((-1)+16)+16:0] AyBz;
  reg  [((-1)+16)+16:0] AzBy;
  reg  [((-1)+16)+16:0] AzBx;
  reg  [((-1)+16)+16:0] AxBz;
  reg  [((-1)+16)+16:0] AxBy;
  reg  [((-1)+16)+16:0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Ay*Bz;
        AzBy <= By*Az;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= Ax*By;
        AyBx <= Ay*Bx;
        Cx <= {AyBz[((-1)+16)+16],AyBz}-{AzBy[((-1)+16)+16],AzBy};
        Cy <= {AzBx[((-1)+16)+16],AzBx}+(-{AxBz[((-1)+16)+16],AxBz});
        Cz <= (-{AyBx[((-1)+16)+16],AyBx})+{AxBy[((-1)+16)+16],AxBy};
      end
endmodule

