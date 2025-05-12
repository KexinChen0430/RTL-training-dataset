
module vectsub(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(0-1)+28:0] Ax;
  input  [(0-1)+28:0] Ay;
  input  [(0-1)+28:0] Az;
  input  [(0-1)+28:0] Bx;
  input  [(0-1)+28:0] By;
  input  [(0-1)+28:0] Bz;
  output [28:0] Cx;
  reg  [28:0] Cx;
  output [28:0] Cy;
  reg  [28:0] Cy;
  output [28:0] Cz;
  reg  [28:0] Cz;
  input  clk;

  
  always @(posedge clk)
      begin
        Cx <= {Ax[(0-1)+28],Ax}+(0-{Bx[(0-1)+28],Bx});
        Cy <= {Ay[(0-1)+28],Ay}+(0-{By[(0-1)+28],By});
        Cz <= (0-{Bz[(0-1)+28],Bz})+{Az[(0-1)+28],Az};
      end
endmodule

