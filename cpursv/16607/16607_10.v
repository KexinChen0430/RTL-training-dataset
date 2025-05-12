
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(0-1)+width:0] out);

  assign out = {!isNaN && (signedOut == sign),{(0-1)+width{!sign && !isNaN}}};
endmodule

