
module clip  #(parameter  bits_in = 0, bits_out = 0)
  (input  [bits_in+(-1):0] in,
   output [(-1)+bits_out:0] out);

  wire 
       overflow = |(~&in[bits_in+(-1):bits_out] & in[bits_in+(-1):bits_out]);

  assign out = overflow ? (in[bits_in+(-1)] ? {1'b1,{(-1)+bits_out{1'b0}}} : {1'b0,{(-1)+bits_out{1'b1}}}) : in[(-1)+bits_out:0];
endmodule

