
module dotproduct29x33(Ax,Ay,Az,Bx,By,Bz,C,clk);

  input  [(0-1)+29:0] Ax;
  input  [(0-1)+29:0] Ay;
  input  [(0-1)+29:0] Az;
  input  [33+(0-1):0] Bx;
  input  [33+(0-1):0] By;
  input  [33+(0-1):0] Bz;
  output [(29+33)+1:0] C;
  reg  [(29+33)+1:0] C;
  input  clk;
  reg  [(33+(0-1))+29:0] AxBx;
  reg  [(33+(0-1))+29:0] AyBy;
  reg  [(33+(0-1))+29:0] AzBz;

  
  always @(posedge clk)
      begin
        AxBx <= Ax*Bx;
        AyBy <= Ay*By;
        AzBz <= Bz*Az;
        C <= ({AxBx[(33+(0-1))+29],AxBx[(33+(0-1))+29],AxBx}+{AyBy[(33+(0-1))+29],AyBy[(33+(0-1))+29],AyBy})+{AzBz[(33+(0-1))+29],AzBz[(33+(0-1))+29],AzBz};
      end
endmodule

