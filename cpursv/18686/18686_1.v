
module B  #(parameter  wid = 3)
  (output [(-1)+wid:0] Q,
   input  [(-1)+wid:0] D,
   input  C);

  prim U[(-1)+wid:0](Q,D,C);
endmodule

