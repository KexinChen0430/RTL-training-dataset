
module mux_one  #(parameter  WIDTH = 2, WIDTH_SZ = $clog2(1+WIDTH))
  (input  [(-1)+WIDTH:0] in,
   input  [(-1)+WIDTH_SZ:0] sel,
   output out);

  assign out = in[sel];
endmodule

