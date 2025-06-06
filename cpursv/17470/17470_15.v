
module desxor2(d,l,q);

  input  [1:32] d,l;
  output [1:32] q;

  assign q = (~d & ((l & d) ^ l)) | ((d & ((~l | l) & d)) ^ (l & d));
endmodule

