
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(-1)+width:0] out);

  assign out = {!isNaN && (signedOut == sign),{(-1)+width{!sign && !isNaN}}};
endmodule

