
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+16:0] Ax;
  input  [(0-1)+16:0] Ay;
  input  [(0-1)+16:0] Az;
  input  [(0-1)+33:0] Bx;
  input  [(0-1)+33:0] By;
  input  [(0-1)+33:0] Bz;
  output [(16+1)+33:0] C;
  reg  [(16+1)+33:0] C;
  input  clk;
  reg  [(33+16)-1:0] AxBx;
  reg  [(33+16)-1:0] AyBy;
  reg  [(33+16)-1:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= {AxBx[(33+16)-1],AxBx[(33+16)-1],AxBx}+({AyBy[(33+16)-1],AyBy[(33+16)-1],AyBy}+{AzBz[(33+16)-1],AzBz[(33+16)-1],AzBz});
      end
endmodule

