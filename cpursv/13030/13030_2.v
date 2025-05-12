
module mux2  #(parameter  WIDTH = 32)
  (input  [WIDTH+(0-1):0] d0,d1,
   input  s,
   output [WIDTH+(0-1):0] y);

  assign y = s ? d1 : d0;
endmodule

