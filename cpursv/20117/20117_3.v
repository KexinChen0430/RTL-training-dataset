
module OR4  #(parameter  SIZE = 4)
  (input  [(-1)+SIZE:0] in,
   output out);

  assign out = |in;
endmodule

