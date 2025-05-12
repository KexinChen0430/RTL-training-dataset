
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+29:0] Ax;
  input  [(0-1)+29:0] Ay;
  input  [(0-1)+29:0] Az;
  input  [(0-1)+33:0] Bx;
  input  [(0-1)+33:0] By;
  input  [(0-1)+33:0] Bz;
  output [(29+1)+33:0] C;
  reg  [(29+1)+33:0] C;
  input  clk;
  reg  [((0-1)+33)+29:0] AxBx;
  reg  [((0-1)+33)+29:0] AyBy;
  reg  [((0-1)+33)+29:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AyBy[((0-1)+33)+29],AyBy[((0-1)+33)+29],AyBy}+({AzBz[((0-1)+33)+29],AzBz[((0-1)+33)+29],AzBz}+{AxBx[((0-1)+33)+29],AxBx[((0-1)+33)+29],AxBx});
      end
endmodule

