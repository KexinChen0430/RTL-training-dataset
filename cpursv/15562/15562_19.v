
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width+(0-1):0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {((((~signedOut & ((signedOut & maxInt) ^ ((signedOut & maxInt) & signedOut))) ^ (((~maxInt & (maxInt & ((signedOut & (~maxInt | maxInt)) & maxInt))) | (maxInt & ~(maxInt & ((signedOut & (~maxInt | maxInt)) & maxInt)))) & ~signedOut)) | ((signedOut & (~maxInt | maxInt)) & ~signedOut)) | ((((~maxInt | maxInt) & ~signedOut) | ~maxInt) & (signedOut & (~maxInt | maxInt)))) & (((~maxInt | maxInt) & ~signedOut) | ~maxInt),{width+(0-1){maxInt}}};
endmodule

