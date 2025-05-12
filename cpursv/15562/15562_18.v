
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width-1:0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {maxInt ^ ((~maxInt | maxInt) & signedOut),{width-1{maxInt}}};
endmodule

