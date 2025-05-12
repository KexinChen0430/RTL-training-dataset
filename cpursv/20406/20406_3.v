
module nop(d,q);

  parameter  WIDTH = 32;
  input  [(-1)+WIDTH:0] d;
  output [(-1)+WIDTH:0] q;

  assign q = d;
endmodule

