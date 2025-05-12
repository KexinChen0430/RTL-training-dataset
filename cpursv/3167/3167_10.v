
module ripemd160_rol(input  [3:0] rx_s,
                     input  [31:0] rx_x,
                     output [31:0] tx_x);

  assign tx_x = rx_x<<rx_s | rx_x>>((-rx_s)+32);
endmodule

