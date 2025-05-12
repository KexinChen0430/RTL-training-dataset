
module mux2  #(parameter  WIDTH = 8)
  (input  wire [(-1)+WIDTH:0] d0,d1,
   input  wire s,
   output wire [(-1)+WIDTH:0] y);

  assign y = s ? d1 : d0;
endmodule

