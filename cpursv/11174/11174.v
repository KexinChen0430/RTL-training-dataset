
module IOBUF(O,IO,I,OEN);

  input  I;
  input  OEN;
  output O;
  inout  IO;

  assign IO = OEN ? 1'bz : I;
  assign I = IO;
endmodule

