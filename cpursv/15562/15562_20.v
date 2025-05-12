
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(0-1)+width:0] out);

  wire  maxInt = isNaN || !sign;

  assign out = {(maxInt & ~signedOut) | (~maxInt & ((signedOut & (~maxInt | maxInt)) | maxInt)),{(0-1)+width{maxInt}}};
endmodule

