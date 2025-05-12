
module mux2  #(parameter  bits = 16)
  (input  sel,
   input  [(-1)+bits:0] d0,d1,
   output [(-1)+bits:0] q);

  assign q = sel ? d1 : d0;
endmodule

