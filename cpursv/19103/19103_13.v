
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [29+(0-1):0] Ax;
  input  [29+(0-1):0] Ay;
  input  [29+(0-1):0] Az;
  input  [33-1:0] Bx;
  input  [33-1:0] By;
  input  [33-1:0] Bz;
  output [(33+29)+1:0] C;
  reg  [(33+29)+1:0] C;
  input  clk;
  reg  [(33+29)-1:0] AxBx;
  reg  [(33+29)-1:0] AyBy;
  reg  [(33+29)-1:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Az*Bz;
        C <= {AzBz[(33+29)-1],AzBz[(33+29)-1],AzBz}+({AyBy[(33+29)-1],AyBy[(33+29)-1],AyBy}+{AxBx[(33+29)-1],AxBx[(33+29)-1],AxBx});
      end
endmodule

