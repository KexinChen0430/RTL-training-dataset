
module zerodetect  #(parameter  WIDTH = 32)
  (input  [WIDTH+(0-1):0] a,
   output y);

  assign y = a == 0;
endmodule

