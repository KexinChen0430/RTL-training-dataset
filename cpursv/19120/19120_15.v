
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(0-1)+16:0] Ax;
  input  [(0-1)+16:0] Ay;
  input  [(0-1)+16:0] Az;
  input  [(0-1)+16:0] Bx;
  input  [(0-1)+16:0] By;
  input  [(0-1)+16:0] Bz;
  output [(1+1)*16:0] Cx;
  reg  [(1+1)*16:0] Cx;
  output [(1+1)*16:0] Cy;
  reg  [(1+1)*16:0] Cy;
  output [(1+1)*16:0] Cz;
  reg  [(1+1)*16:0] Cz;
  input  clk;
  reg  [((1+1)*16)-1:0] AyBz;
  reg  [((1+1)*16)-1:0] AzBy;
  reg  [((1+1)*16)-1:0] AzBx;
  reg  [((1+1)*16)-1:0] AxBz;
  reg  [((1+1)*16)-1:0] AxBy;
  reg  [((1+1)*16)-1:0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Bz*Ay;
        AzBy <= By*Az;
        AzBx <= Bx*Az;
        AxBz <= Ax*Bz;
        AxBy <= By*Ax;
        AyBx <= Bx*Ay;
        Cx <= (0-{AzBy[((1+1)*16)-1],AzBy})+{AyBz[((1+1)*16)-1],AyBz};
        Cy <= {AzBx[((1+1)*16)-1],AzBx}+(-{AxBz[((1+1)*16)-1],AxBz});
        Cz <= {AxBy[((1+1)*16)-1],AxBy}-{AyBx[((1+1)*16)-1],AyBx};
      end
endmodule

