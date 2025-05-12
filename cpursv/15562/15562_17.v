
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width+(-1):0] out);

  wire  maxInt = isNaN || !sign;

  assign out = {((maxInt | (signedOut & (~maxInt | maxInt))) & ((((signedOut | ~signedOut) | ((maxInt | (signedOut & (~maxInt | maxInt))) & (~signedOut & (~maxInt | maxInt)))) & ((maxInt & ((maxInt & (signedOut | ~signedOut)) & maxInt)) ^ (maxInt & (maxInt & signedOut)))) ^ (((signedOut | ~signedOut) | ((maxInt | (signedOut & (~maxInt | maxInt))) & (~signedOut & (~maxInt | maxInt)))) & (((maxInt & signedOut) & ~((maxInt & signedOut) & signedOut)) | (~(maxInt & signedOut) & ((maxInt & signedOut) & signedOut)))))) ^ ((maxInt | (signedOut & (~maxInt | maxInt))) & (((signedOut | ~signedOut) | ((maxInt | (signedOut & (~maxInt | maxInt))) & (~signedOut & (~maxInt | maxInt)))) & (signedOut & (~maxInt | (~signedOut & maxInt))))),{width+(-1){maxInt}}};
endmodule

