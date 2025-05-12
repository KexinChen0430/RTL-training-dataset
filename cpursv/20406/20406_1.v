
module nop(d,q);

  parameter  WIDTH = 32;
  input  [WIDTH+(0-1):0] d;
  output [WIDTH+(0-1):0] q;

  assign q = d;
endmodule

