
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+29:0] Ax;
  input  [(0-1)+29:0] Ay;
  input  [(0-1)+29:0] Az;
  input  [33-1:0] Bx;
  input  [33-1:0] By;
  input  [33-1:0] Bz;
  output [(33+29)+1:0] C;
  reg  [(33+29)+1:0] C;
  input  clk;
  reg  [29+(33-1):0] AxBx;
  reg  [29+(33-1):0] AyBy;
  reg  [29+(33-1):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AyBy[29+(33-1)],AyBy[29+(33-1)],AyBy}+({AzBz[29+(33-1)],AzBz[29+(33-1)],AzBz}+{AxBx[29+(33-1)],AxBx[29+(33-1)],AxBx});
      end
endmodule

