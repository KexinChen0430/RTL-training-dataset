
module f3_add1(a,c);

  input  [1:0] a;
  output [1:0] c;

  assign c[0] = ~a[1] & ~a[0];
  assign c[1] = ~a[1] & a[0];
endmodule

