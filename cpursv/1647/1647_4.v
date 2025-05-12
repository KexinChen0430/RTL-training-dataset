
module LED_Segment_Mapper(input  LED_ENABLE_1,
                          input  LED_ENABLE_2,
                          input  [15:0] LED_DATA_1,
                          input  [15:0] LED_DATA_2,
                          output [6:0] HEX0,
                          output [6:0] HEX1,
                          output [6:0] HEX2,
                          output [6:0] HEX3,
                          output [6:0] HEX4,
                          output [6:0] HEX5,
                          input  CLK);

  reg  [15:0] led_out_reg;

  
  initial  
  begin
    led_out_reg = 16'hFFFF;
  end
  
  always @(posedge CLK)
      begin
        led_out_reg[0] <= ~(((((LED_ENABLE_1 & LED_DATA_1[0]) | (((LED_ENABLE_1 & LED_DATA_2[0]) & LED_ENABLE_2) | ((LED_DATA_2[0] & LED_DATA_1[0]) & LED_ENABLE_1))) & LED_ENABLE_2) | (LED_ENABLE_1 & LED_DATA_1[0])) | ((LED_ENABLE_2 & LED_DATA_2[0]) | ((((LED_DATA_2[0] & LED_DATA_1[0]) & LED_ENABLE_1) & (LED_ENABLE_1 & (LED_ENABLE_2 & LED_DATA_1[0]))) | ((LED_DATA_1[0] & (LED_ENABLE_1 | ((LED_ENABLE_1 & LED_DATA_2[0]) | LED_ENABLE_2))) & LED_DATA_2[0]))));
      end
  assign HEX3[0] = led_out_reg[0];
  assign HEX0[6:4] = ~3'h0;
endmodule

