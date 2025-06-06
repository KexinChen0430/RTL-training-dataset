
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [width-1:0] out);

  assign out = {!isNaN && (signedOut == sign),{width-1{!sign && !isNaN}}};
endmodule

