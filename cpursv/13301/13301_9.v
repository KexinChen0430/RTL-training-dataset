
module signal_extend  #(parameter  OUT_DATA_WIDTH = 32, IN_DATA_WIDTH = 16)
  (input  [(0-1)+IN_DATA_WIDTH:0] signal_in,
   output [OUT_DATA_WIDTH+(0-1):0] signal_out);

  assign signal_out = {{OUT_DATA_WIDTH-IN_DATA_WIDTH{signal_in[(0-1)+IN_DATA_WIDTH]}},signal_in};
endmodule

