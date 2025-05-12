
module crossproduct16x16(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [16+(0-1):0] Ax;
  input  [16+(0-1):0] Ay;
  input  [16+(0-1):0] Az;
  input  [16+(0-1):0] Bx;
  input  [16+(0-1):0] By;
  input  [16+(0-1):0] Bz;
  output [(1+1)*16:0] Cx;
  reg  [(1+1)*16:0] Cx;
  output [(1+1)*16:0] Cy;
  reg  [(1+1)*16:0] Cy;
  output [(1+1)*16:0] Cz;
  reg  [(1+1)*16:0] Cz;
  input  clk;
  reg  [(0-1)+((1+1)*16):0] AyBz;
  reg  [(0-1)+((1+1)*16):0] AzBy;
  reg  [(0-1)+((1+1)*16):0] AzBx;
  reg  [(0-1)+((1+1)*16):0] AxBz;
  reg  [(0-1)+((1+1)*16):0] AxBy;
  reg  [(0-1)+((1+1)*16):0] AyBx;

  
  always @(posedge clk)
      begin
        AyBz <= Ay*Bz;
        AzBy <= By*Az;
        AzBx <= Bx*Az;
        AxBz <= Bz*Ax;
        AxBy <= By*Ax;
        AyBx <= Bx*Ay;
        Cx <= {AyBz[(0-1)+((1+1)*16)],AyBz}+(-{AzBy[(0-1)+((1+1)*16)],AzBy});
        Cy <= {AzBx[(0-1)+((1+1)*16)],AzBx}-{AxBz[(0-1)+((1+1)*16)],AxBz};
        Cz <= {AxBy[(0-1)+((1+1)*16)],AxBy}+(0-{AyBx[(0-1)+((1+1)*16)],AyBx});
      end
endmodule

