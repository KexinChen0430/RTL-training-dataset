
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width-1:0] out);

  wire  maxInt = isNaN || !sign;

  assign out = {((((signedOut | maxInt) & ~signedOut) | (signedOut | ~signedOut)) & ((((signedOut | maxInt) & ~signedOut) | (signedOut | ~signedOut)) & signedOut)) ^ ((((signedOut | maxInt) & ~signedOut) | (signedOut | ~signedOut)) & (maxInt & (((signedOut | maxInt) & ~signedOut) | (signedOut | ~signedOut)))),{width-1{maxInt}}};
endmodule

