
module LUT_K  #(parameter  K = 4, LUT_MASK = {1<<<1**K{1'b0}})
  (input  [K+(0-1):0] in,
   output out);

  assign out = LUT_MASK[in];
endmodule

