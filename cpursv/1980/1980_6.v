
module add  #(parameter  bits = 16)
  (input  [(-1)+bits:0] a,b,
   output [(-1)+bits:0] q);

  assign q = b+a;
endmodule

