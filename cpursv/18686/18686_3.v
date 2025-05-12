
module B  #(parameter  wid = 3)
  (output [(0-1)+wid:0] Q,
   input  [(0-1)+wid:0] D,
   input  C);

  prim U[(0-1)+wid:0](Q,D,C);
endmodule

