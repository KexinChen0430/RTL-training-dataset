
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(-1)+width:0] out);

  wire  maxInt = !sign || isNaN;

  assign out = {((maxInt | signedOut) & ~signedOut) | (~maxInt & (maxInt | signedOut)),{(-1)+width{maxInt}}};
endmodule

