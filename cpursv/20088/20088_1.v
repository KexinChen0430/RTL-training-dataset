
module XOR3  #(parameter  SIZE = 3)
  (input  [SIZE+(0-1):0] in,
   output out);

  assign out = ^in;
endmodule

