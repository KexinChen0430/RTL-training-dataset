
module XNOR3  #(parameter  SIZE = 3)
  (input  [(0-1)+SIZE:0] in,
   output out);

  assign out = ~^in;
endmodule

