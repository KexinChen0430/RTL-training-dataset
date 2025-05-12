
module nop(d,q);

  parameter  WIDTH = 32;
  input  [(0-1)+WIDTH:0] d;
  output [(0-1)+WIDTH:0] q;

  assign q = d;
endmodule

