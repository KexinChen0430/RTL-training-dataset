
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(0-1)+width:0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {((signedOut | maxInt) & (signedOut & ((~signedOut | (signedOut | maxInt)) | (~signedOut & (signedOut | maxInt))))) ^ ((signedOut | maxInt) & (((~signedOut | (signedOut | maxInt)) | (~signedOut & (signedOut | maxInt))) & maxInt)),{(0-1)+width{maxInt}}};
endmodule

