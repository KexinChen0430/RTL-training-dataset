
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width-1:0] out);

  assign out = {(signedOut == sign) && !isNaN,{width-1{!sign && !isNaN}}};
endmodule

