
module techlib_slice(A,Y);

  parameter  OFFSET = 0;
  parameter  A_WIDTH = 0;
  parameter  Y_WIDTH = 0;
  input  [(-1)+A_WIDTH:0] A;
  output [(-1)+Y_WIDTH:0] Y;

  assign Y = A>>OFFSET;
endmodule

