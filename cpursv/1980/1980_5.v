
module add  #(parameter  bits = 16)
  (input  [bits+(0-1):0] a,b,
   output [bits+(0-1):0] q);

  assign q = b+a;
endmodule

