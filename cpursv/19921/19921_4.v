
module const(out);

  parameter  WIDTH = 32;
  parameter  VAL = 31;
  output [WIDTH+(0-1):0] out;

  assign out = VAL;
endmodule

