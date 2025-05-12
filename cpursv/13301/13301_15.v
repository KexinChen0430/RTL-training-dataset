
module signal_extend  #(parameter  OUT_DATA_WIDTH = 32, IN_DATA_WIDTH = 16)
  (input  [(-1)+IN_DATA_WIDTH:0] signal_in,
   output [(-1)+OUT_DATA_WIDTH:0] signal_out);

  assign signal_out = {{OUT_DATA_WIDTH+(0-IN_DATA_WIDTH){signal_in[(-1)+IN_DATA_WIDTH]}},signal_in};
endmodule

