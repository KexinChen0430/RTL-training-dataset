
module aur1_CHANNEL_ERROR_DETECT(SOFT_ERROR,HARD_ERROR,LANE_UP,USER_CLK,POWER_DOWN,
                                 CHANNEL_SOFT_ERROR,CHANNEL_HARD_ERROR,RESET_CHANNEL);

  input  [0:3] SOFT_ERROR;
  input  [0:3] HARD_ERROR;
  input  [0:3] LANE_UP;
  input  USER_CLK;
  input  POWER_DOWN;
  output CHANNEL_SOFT_ERROR;
  output CHANNEL_HARD_ERROR;
  output RESET_CHANNEL;
  reg  CHANNEL_SOFT_ERROR;
  reg  CHANNEL_HARD_ERROR;
  reg  RESET_CHANNEL;
  reg  [0:3] soft_error_r;
  reg  [0:3] hard_error_r;
  wire channel_soft_error_c;
  wire channel_hard_error_c;
  wire reset_channel_c;

  
  always @(posedge USER_CLK)
      begin
        soft_error_r <= #1 SOFT_ERROR;
        hard_error_r <= #1 HARD_ERROR;
      end
  
  initial    CHANNEL_SOFT_ERROR = 1'b1;
  assign channel_soft_error_c = (soft_error_r[0] | soft_error_r[3]) | (soft_error_r[1] | soft_error_r[2]);
  
  always @(posedge USER_CLK)
      CHANNEL_SOFT_ERROR <= #1 channel_soft_error_c;
  
  initial    CHANNEL_HARD_ERROR = 1'b1;
  assign channel_hard_error_c = (hard_error_r[1] | hard_error_r[2]) | (hard_error_r[3] | hard_error_r[0]);
  
  always @(posedge USER_CLK)
      CHANNEL_HARD_ERROR <= #1 channel_hard_error_c;
  
  initial    RESET_CHANNEL = 1'b1;
  assign reset_channel_c = !LANE_UP[3] | (!LANE_UP[1] | (!LANE_UP[0] | !LANE_UP[2]));
  
  always @(posedge USER_CLK)
      RESET_CHANNEL <= #1 reset_channel_c | POWER_DOWN;
endmodule

