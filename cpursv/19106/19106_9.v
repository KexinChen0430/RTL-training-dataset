
module vectsub(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,clk);

  input  [(-1)+28:0] Ax;
  input  [(-1)+28:0] Ay;
  input  [(-1)+28:0] Az;
  input  [(-1)+28:0] Bx;
  input  [(-1)+28:0] By;
  input  [(-1)+28:0] Bz;
  output [28:0] Cx;
  reg  [28:0] Cx;
  output [28:0] Cy;
  reg  [28:0] Cy;
  output [28:0] Cz;
  reg  [28:0] Cz;
  input  clk;

  
  always @(posedge clk)
      begin
        Cx <= {Ax[(-1)+28],Ax}-{Bx[(-1)+28],Bx};
        Cy <= {Ay[(-1)+28],Ay}-{By[(-1)+28],By};
        Cz <= {Az[(-1)+28],Az}-{Bz[(-1)+28],Bz};
      end
endmodule

