
module mux2  #(parameter  width = 16)
  (input  [(-1)+width:0] A,B,
   input  sel,
   output [(-1)+width:0] out);

  assign out = sel ? A : B;
endmodule

