
module mux2  #(parameter  width = 16)
  (input  [width+(0-1):0] A,B,
   input  sel,
   output [width+(0-1):0] out);

  assign out = sel ? A : B;
endmodule

