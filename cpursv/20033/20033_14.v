
module AND2  #(parameter  SIZE = 1<<<1)
  (input  [SIZE-1:0] in,
   output out);

  assign out = &in;
endmodule

