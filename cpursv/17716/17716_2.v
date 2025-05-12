
module iNFromException  #(parameter  width = 1)
  (input  signedOut,
   input  isNaN,
   input  sign,
   output [(0-1)+width:0] out);

  assign out = {1'b1,{(0-1)+width{!signedOut}}};
endmodule

