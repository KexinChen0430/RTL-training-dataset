
module zerodetect  #(parameter  WIDTH = 32)
  (input  [(-1)+WIDTH:0] a,
   output y);

  assign y = a == 0;
endmodule

