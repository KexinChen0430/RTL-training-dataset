
module add1(a,b,ci,sum,co);

  input  a,b,ci;
  output sum,co;

  assign {co,sum} = ci+(b+a);
endmodule

