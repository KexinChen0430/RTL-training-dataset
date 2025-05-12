
module zeroer(d,en,q);

  parameter  WIDTH = 32;
  input  en;
  input  [WIDTH+(0-1):0] d;
  output [WIDTH+(0-1):0] q;

  assign q = en ? d : 0;
endmodule

