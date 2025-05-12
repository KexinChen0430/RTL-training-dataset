
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width+(0-1):0] out);

  assign out = {1'b1,{width+(0-1){!signedOut}}};
endmodule

