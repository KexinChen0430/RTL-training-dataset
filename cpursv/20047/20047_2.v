
module XNOR4  #(parameter  SIZE = 4)
  (input  [SIZE+(-1):0] in,
   output out);

  assign out = ~^in;
endmodule

