
module _90_pow(A,B,Y);

  parameter  A_SIGNED = 0;
  parameter  B_SIGNED = 0;
  parameter  A_WIDTH = 1;
  parameter  B_WIDTH = 1;
  parameter  Y_WIDTH = 1;
  input  [(0-1)+A_WIDTH:0] A;
  input  [B_WIDTH+(0-1):0] B;
  output [(0-1)+Y_WIDTH:0] Y;
  wire  _TECHMAP_FAIL_ = 1;


endmodule

