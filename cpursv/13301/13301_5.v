
module signal_extend  #(parameter  OUT_DATA_WIDTH = 32, IN_DATA_WIDTH = 16)
  (input  [IN_DATA_WIDTH+(0-1):0] signal_in,
   output [(0-1)+OUT_DATA_WIDTH:0] signal_out);

  assign signal_out = {{(0-IN_DATA_WIDTH)+OUT_DATA_WIDTH{signal_in[IN_DATA_WIDTH+(0-1)]}},signal_in};
endmodule

