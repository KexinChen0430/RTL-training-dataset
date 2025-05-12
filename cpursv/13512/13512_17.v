
module techlib_concat(A,B,Y);

  parameter  A_WIDTH = 0;
  parameter  B_WIDTH = 0;
  input  [(-1)+A_WIDTH:0] A;
  input  [B_WIDTH+(-1):0] B;
  output [((-1)+A_WIDTH)+B_WIDTH:0] Y;

  assign Y = {B,A};
endmodule

