
module SB_RGB_DRV(input  RGBLEDEN,
                  input  RGB0PWM,
                  input  RGB1PWM,
                  input  RGB2PWM,
                  input  RGBPU,
                  output RGB0,
                  output RGB1,
                  output RGB2);

  parameter  CURRENT_MODE = "0b0";
  parameter  RGB0_CURRENT = "0b000000";
  parameter  RGB1_CURRENT = "0b000000";
  parameter  RGB2_CURRENT = "0b000000";


endmodule

