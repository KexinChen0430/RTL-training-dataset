module i2s_out(input clock, input reset, input[15:0] left_data,
 input[15:0] right_data, output mclk, output lrck, output sclk, output reg sdin);