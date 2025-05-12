
module TBUF(O,I,OEN);

  input  I;
  input  OEN;
  output O;

  assign O = OEN ? 1'bz : I;
endmodule

