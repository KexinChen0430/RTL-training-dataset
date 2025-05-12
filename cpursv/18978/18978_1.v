
module adder(q,a,b);

  input  a,b;
  output [1:0] q;

  assign q = b+a;
endmodule

