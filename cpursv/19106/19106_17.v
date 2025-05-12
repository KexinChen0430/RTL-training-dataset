
module vectsub(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [28+(0-1):0] Ax;
  input  [28+(0-1):0] Ay;
  input  [28+(0-1):0] Az;
  input  [28+(0-1):0] Bx;
  input  [28+(0-1):0] By;
  input  [28+(0-1):0] Bz;
  output [28:0] Cx;
  reg  [28:0] Cx;
  output [28:0] Cy;
  reg  [28:0] Cy;
  output [28:0] Cz;
  reg  [28:0] Cz;
  input  clk;

  
  always @(posedge clk)
      begin
        Cx <= {Ax[28+(0-1)],Ax}+(0-{Bx[28+(0-1)],Bx});
        Cy <= {Ay[28+(0-1)],Ay}-{By[28+(0-1)],By};
        Cz <= {Az[28+(0-1)],Az}+(-{Bz[28+(0-1)],Bz});
      end
endmodule

