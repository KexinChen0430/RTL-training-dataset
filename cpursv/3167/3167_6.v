
module ripemd160_rol(input  [3:0] rx_s,
                     input  [31:0] rx_x,
                     output [31:0] tx_x);

  assign tx_x = rx_x>>((0-rx_s)+32) | (rx_x*(2**rx_s));
endmodule

