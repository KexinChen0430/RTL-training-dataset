
module XOR2  #(parameter  SIZE = 2)
  (input  [(0-1)+SIZE:0] in,
   output out);

  assign out = ^in;
endmodule

