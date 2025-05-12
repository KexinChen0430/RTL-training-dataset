
module NAND2  #(parameter  SIZE = 1+1)
  (input  [(0-1)+SIZE:0] in,
   output out);

  assign out = ~&in;
endmodule

