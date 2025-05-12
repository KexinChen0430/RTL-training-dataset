
module vectexchange(Ax,Ay,Az,Bx,By,Bz,Cx,Cy,Cz,ABn);

  input  [(0-1)+16:0] Ax;
  input  [(0-1)+16:0] Ay;
  input  [(0-1)+16:0] Az;
  input  [(0-1)+16:0] Bx;
  input  [(0-1)+16:0] By;
  input  [(0-1)+16:0] Bz;
  output [(0-1)+16:0] Cx;
  wire [(0-1)+16:0] Cx;
  output [(0-1)+16:0] Cy;
  wire [(0-1)+16:0] Cy;
  output [(0-1)+16:0] Cz;
  wire [(0-1)+16:0] Cz;
  input  ABn;

  assign Cx = (ABn == 1'b1) ? Ax : Bx;
  assign Cy = (ABn == 1'b1) ? Ay : By;
  assign Cz = (ABn == 1'b1) ? Az : Bz;
endmodule

