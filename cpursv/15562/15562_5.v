
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width+(0-1):0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {(((signedOut | ~signedOut) | ((~signedOut & (~maxInt | (signedOut | (maxInt & (signedOut | ~signedOut))))) & (signedOut | (maxInt & (signedOut | ~signedOut))))) & (signedOut & (~maxInt | (signedOut | (maxInt & (signedOut | ~signedOut)))))) ^ (maxInt & ((signedOut | ~signedOut) | ((~signedOut & (~maxInt | (signedOut | (maxInt & (signedOut | ~signedOut))))) & (signedOut | (maxInt & (signedOut | ~signedOut)))))),{width+(0-1){maxInt}}};
endmodule

