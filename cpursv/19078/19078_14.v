
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16+(0-1):0] Ax;
  input  [16+(0-1):0] Ay;
  input  [16+(0-1):0] Az;
  input  [(0-1)+33:0] Bx;
  input  [(0-1)+33:0] By;
  input  [(0-1)+33:0] Bz;
  output [(33+16)+1:0] C;
  reg  [(33+16)+1:0] C;
  input  clk;
  reg  [16+((0-1)+33):0] AxBx;
  reg  [16+((0-1)+33):0] AyBy;
  reg  [16+((0-1)+33):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AxBx[16+((0-1)+33)],AxBx[16+((0-1)+33)],AxBx}+{AzBz[16+((0-1)+33)],AzBz[16+((0-1)+33)],AzBz})+{AyBy[16+((0-1)+33)],AyBy[16+((0-1)+33)],AyBy};
      end
endmodule

