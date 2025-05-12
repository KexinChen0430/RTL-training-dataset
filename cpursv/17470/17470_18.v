
module desxor2(d,l,q);

  input  [1:32] d,l;
  output [1:32] q;

  assign q = (((d & l) ^ l) & ~((d | ~d) & ((d ^ (d & l)) & (d | ((d & l) ^ l))))) | (~((d & l) ^ l) & ((d | ~d) & ((d ^ (d & l)) & (d | ((d & l) ^ l)))));
endmodule

