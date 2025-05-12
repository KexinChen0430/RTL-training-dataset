
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [29-1:0] Ax;
  input  [29-1:0] Ay;
  input  [29-1:0] Az;
  input  [33+(0-1):0] Bx;
  input  [33+(0-1):0] By;
  input  [33+(0-1):0] Bz;
  output [1+(29+33):0] C;
  reg  [1+(29+33):0] C;
  input  clk;
  reg  [(0-1)+(29+33):0] AxBx;
  reg  [(0-1)+(29+33):0] AyBy;
  reg  [(0-1)+(29+33):0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Bx*Ax;
        AyBy <= By*Ay;
        AzBz <= Bz*Az;
        C <= ({AxBx[(0-1)+(29+33)],AxBx[(0-1)+(29+33)],AxBx}+{AyBy[(0-1)+(29+33)],AyBy[(0-1)+(29+33)],AyBy})+{AzBz[(0-1)+(29+33)],AzBz[(0-1)+(29+33)],AzBz};
      end
endmodule

