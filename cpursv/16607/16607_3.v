
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(-1)+width:0] out);

  assign out = {(signedOut == sign) && !isNaN,{(-1)+width{!isNaN && !sign}}};
endmodule

