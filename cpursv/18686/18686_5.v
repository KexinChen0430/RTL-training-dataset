
module B  #(parameter  wid = 3)
  (output [wid+(0-1):0] Q,
   input  [wid+(0-1):0] D,
   input  C);

  prim U[wid+(0-1):0](Q,D,C);
endmodule

