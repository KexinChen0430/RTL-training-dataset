
module techlib_tribuf(A,EN,Y);

  parameter  WIDTH = 0;
  input  [(0-1)+WIDTH:0] A;
  input  EN;
  output [(0-1)+WIDTH:0] Y;

  assign Y = EN ? A : 'bz;
endmodule

