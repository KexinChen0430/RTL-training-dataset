
module const(out);

  parameter  WIDTH = 32;
  parameter  VAL = 31;
  output [(0-1)+WIDTH:0] out;

  assign out = VAL;
endmodule

