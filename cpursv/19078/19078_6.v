
module dotproduct16x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [16-1:0] Ax;
  input  [16-1:0] Ay;
  input  [16-1:0] Az;
  input  [(0-1)+33:0] Bx;
  input  [(0-1)+33:0] By;
  input  [(0-1)+33:0] Bz;
  output [1+(16+33):0] C;
  reg  [1+(16+33):0] C;
  input  clk;
  reg  [((0-1)+33)+16:0] AxBx;
  reg  [((0-1)+33)+16:0] AyBy;
  reg  [((0-1)+33)+16:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AzBz[((0-1)+33)+16],AzBz[((0-1)+33)+16],AzBz}+{AyBy[((0-1)+33)+16],AyBy[((0-1)+33)+16],AyBy})+{AxBx[((0-1)+33)+16],AxBx[((0-1)+33)+16],AxBx};
      end
endmodule

