
module desxor2(d,l,q);

  input  [1:32] d,l;
  output [1:32] q;

  assign q = ((l & ~d) | ((l | (~d | ~l)) & d)) & (~d | ~l);
endmodule

