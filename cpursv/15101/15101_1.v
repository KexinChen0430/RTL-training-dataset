
module my_decoder(d,q);

  input  [5:0] d;
  output [63:0] q;

  assign q = (2**d)*1'b1;
endmodule

