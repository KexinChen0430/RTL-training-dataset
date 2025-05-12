
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width+(0-1):0] out);

  wire  maxInt = isNaN || !sign;

  assign out = {((((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & (((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & maxInt)) & ~((((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & signedOut) & ((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))))) | (~(((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & (((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & maxInt)) & ((((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))) & signedOut) & ((signedOut | ~signedOut) | ((~signedOut & (maxInt | ~maxInt)) & (maxInt | (signedOut & (maxInt | ~maxInt))))))),{width+(0-1){maxInt}}};
endmodule

