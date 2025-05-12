
module B  #(parameter  wid = 3)
  (output [wid-1:0] Q,
   input  [wid-1:0] D,
   input  C);

  prim U[wid-1:0](Q,D,C);
endmodule

