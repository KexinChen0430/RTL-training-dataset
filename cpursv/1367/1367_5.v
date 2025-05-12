
module mux2  #(parameter  WIDTH = 8)
  (input  [(0-1)+WIDTH:0] d0,
   input  [(0-1)+WIDTH:0] d1,
   input  s,
   output [(0-1)+WIDTH:0] y);

  assign y = s ? d1 : d0;
endmodule

