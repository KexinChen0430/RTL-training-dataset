
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [29-1:0] Ax;
  input  [29-1:0] Ay;
  input  [29-1:0] Az;
  input  [33-1:0] Bx;
  input  [33-1:0] By;
  input  [33-1:0] Bz;
  output [1+(33+29):0] C;
  reg  [1+(33+29):0] C;
  input  clk;
  reg  [(0-1)+(33+29):0] AxBx;
  reg  [(0-1)+(33+29):0] AyBy;
  reg  [(0-1)+(33+29):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= {AzBz[(0-1)+(33+29)],AzBz[(0-1)+(33+29)],AzBz}+({AyBy[(0-1)+(33+29)],AyBy[(0-1)+(33+29)],AyBy}+{AxBx[(0-1)+(33+29)],AxBx[(0-1)+(33+29)],AxBx});
      end
endmodule

