
module clip  #(parameter  bits_in = 0, bits_out = 0)
  (input  [(-1)+bits_in:0] in,
   output [bits_out-1:0] out);

  wire 
       overflow = |(~&in[(-1)+bits_in:bits_out] & in[(-1)+bits_in:bits_out]);

  assign out = overflow ? (in[(-1)+bits_in] ? {1'b1,{bits_out-1{1'b0}}} : {1'b0,{bits_out-1{1'b1}}}) : in[bits_out-1:0];
endmodule

