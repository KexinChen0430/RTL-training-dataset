
module Mux(input  D0,
           input  D1,
           input  s,
           output Y);

  assign Y = s ? D1 : D0;
endmodule

