
module add  #(parameter  bits = 16)
  (input  [(0-1)+bits:0] a,b,
   output [(0-1)+bits:0] q);

  assign q = a+b;
endmodule

