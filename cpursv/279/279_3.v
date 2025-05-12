
module mux_one  #(parameter  WIDTH = 2, WIDTH_SZ = $clog2(1+WIDTH))
  (input  [WIDTH+(0-1):0] in,
   input  [WIDTH_SZ-1:0] sel,
   output out);

  assign out = in[sel];
endmodule

