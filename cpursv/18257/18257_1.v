
module TBUF(O,I,OEN);

  input  I,OEN;
  output O;

  assign O = OEN ? I : 1'bz;
endmodule

