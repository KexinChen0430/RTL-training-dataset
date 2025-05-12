
module TriState(O,IO,OE,I);

  parameter  width = 1;
  input  OE;
  input  [(-1)+width:0] I;
  output [(-1)+width:0] O;
  inout  [(-1)+width:0] IO;

  assign IO = OE ? I : {width{1'bz}};
  assign O = IO;
endmodule

