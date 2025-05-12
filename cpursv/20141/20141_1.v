
module NAND3  #(parameter  SIZE = 3)
  (input  [(-1)+SIZE:0] in,
   output out);

  assign out = ~&in;
endmodule

