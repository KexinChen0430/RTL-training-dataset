
module TriState(O,IO,OE,I);

  parameter  width = 1;
  input  OE;
  input  [width+(0-1):0] I;
  output [width+(0-1):0] O;
  inout  [width+(0-1):0] IO;

  assign IO = OE ? I : {width{1'bz}};
  assign O = IO;
endmodule

