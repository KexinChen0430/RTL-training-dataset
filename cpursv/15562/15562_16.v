
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(-1)+width:0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {(signedOut & ~maxInt) | (maxInt ^ (((~maxInt | maxInt) & signedOut) & maxInt)),{(-1)+width{maxInt}}};
endmodule

