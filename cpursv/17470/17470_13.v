
module desxor2(d,l,q);

  input  [1:32] d,l;
  output [1:32] q;

  assign q = (((l & ~l) ^ (((~d | d) & (d & (l | ~l))) & ~l)) & (d ^ (d & l))) | ((((~d | d) & (d & (l | ~l))) & ~d) ^ (~d & l));
endmodule

