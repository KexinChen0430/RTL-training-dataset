
module techlib_concat(A,B,Y);

  parameter  A_WIDTH = 0;
  parameter  B_WIDTH = 0;
  input  [A_WIDTH-1:0] A;
  input  [(0-1)+B_WIDTH:0] B;
  output [(B_WIDTH+A_WIDTH)+(0-1):0] Y;

  assign Y = {B,A};
endmodule

