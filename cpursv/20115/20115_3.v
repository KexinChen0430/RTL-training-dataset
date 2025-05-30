
module zeroer(d,en,q);

  parameter  WIDTH = 32;
  input  en;
  input  [(0-1)+WIDTH:0] d;
  output [(0-1)+WIDTH:0] q;

  assign q = en ? d : 0;
endmodule

