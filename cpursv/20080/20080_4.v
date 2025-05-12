
module XOR4  #(parameter  SIZE = 4)
  (input  [(0-1)+SIZE:0] in,
   output out);

  assign out = ^in;
endmodule

