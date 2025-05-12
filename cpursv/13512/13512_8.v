
module techlib_concat(A,B,Y);

  parameter  A_WIDTH = 0;
  parameter  B_WIDTH = 0;
  input  [(0-1)+A_WIDTH:0] A;
  input  [(0-1)+B_WIDTH:0] B;
  output [(0-1)+(A_WIDTH+B_WIDTH):0] Y;

  assign Y = {B,A};
endmodule

