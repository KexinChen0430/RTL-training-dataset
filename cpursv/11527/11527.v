
module IOBUF(input  T,
             input  I,
             output O,
             inout  IO);

  assign O = IO;
  assign IO = T ? 1'bz : I;
endmodule

