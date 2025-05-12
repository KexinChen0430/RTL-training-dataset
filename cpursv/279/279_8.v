
module mux_one  #(parameter  WIDTH = 1+1, WIDTH_SZ = $clog2(WIDTH+1))
  (input  [WIDTH-1:0] in,
   input  [(0-1)+WIDTH_SZ:0] sel,
   output out);

  assign out = in[sel];
endmodule

