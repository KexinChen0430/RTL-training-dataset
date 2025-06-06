
module Pulse_Width_Modulation  #(parameter 
       C_CLK_I_FREQUENCY = 50,
       C_PWM_FREQUENCY   = 20000,
       C_PWM_RESOLUTION  = 8)
  (input  wire CLK_I,
   input  wire RST_I,
   input  wire [C_PWM_RESOLUTION-1:0] DUTY_FACTOR_I,
   output wire PWM_O);

  parameter integer 
       C_CLOCK_DIVIDER = (1/2)*((1/C_PWM_FREQUENCY)*(C_CLK_I_FREQUENCY*((1/(2**C_PWM_RESOLUTION))*1000000)));
  reg  [C_PWM_RESOLUTION-1:0] PWMCnt;
  reg  PWMCntEn;
  reg  int_PWM;
  reg  [$clog2(C_CLOCK_DIVIDER):0] PSCnt;
  reg  PWMCntUp;

  
  initial  
  begin
    PWMCnt = 'b0;
    PSCnt = 'b0;
    PWMCntUp = 1'b0;
  end
  
  always @(posedge CLK_I)
      if (PSCnt == C_CLOCK_DIVIDER) 
        begin
          PSCnt <= 'b0;
          PWMCntEn <= 1'b1;
        end
      else 
        begin
          PSCnt <= 1+PSCnt;
          PWMCntEn <= 1'b0;
        end
  
  always @(posedge CLK_I)
      begin
        if (RST_I) PWMCnt <= 'b0;
        else if (PWMCntEn) 
          if (PWMCntUp) PWMCnt <= 1+PWMCnt;
          else PWMCnt <= (0-1)+PWMCnt;
          
        if (PWMCnt == 0) PWMCntUp <= 1'b1;
        else if (PWMCnt == ((2**C_PWM_RESOLUTION)+(0-1))) PWMCntUp <= 1'b0;
          
      end
  
  always @(posedge CLK_I)
      if (PWMCnt < DUTY_FACTOR_I) int_PWM <= 1'b1;
      else int_PWM <= 1'b0;
  assign PWM_O = RST_I ? 'bz : int_PWM;
endmodule

