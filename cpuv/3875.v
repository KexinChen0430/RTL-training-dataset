module sevseg_decoder(val, a, b, c, d, e, f, g);
  input [3:0] val;
  output reg a, b, c, d, e, f, g;
  parameter led_on = 1'b0;
  parameter led_off = 1'b1;
  always @(val)
  	case (val)
  	endcase
endmodule