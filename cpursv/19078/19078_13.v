
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(-1)+16:0] Ax;
  input  [(-1)+16:0] Ay;
  input  [(-1)+16:0] Az;
  input  [(-1)+33:0] Bx;
  input  [(-1)+33:0] By;
  input  [(-1)+33:0] Bz;
  output [33+(16+1):0] C;
  reg  [33+(16+1):0] C;
  input  clk;
  reg  [((-1)+33)+16:0] AxBx;
  reg  [((-1)+33)+16:0] AyBy;
  reg  [((-1)+33)+16:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AxBx[((-1)+33)+16],AxBx[((-1)+33)+16],AxBx}+{AzBz[((-1)+33)+16],AzBz[((-1)+33)+16],AzBz})+{AyBy[((-1)+33)+16],AyBy[((-1)+33)+16],AyBy};
      end
endmodule

