
module pwm_fade(clk,trigger,drive);

  input  trigger;
  input  clk;
  output drive;
  parameter  LEVEL_BITS = 8;
  parameter  LOCAL_MINERS = 1;
  reg  [LEVEL_BITS+(0-1):0]  pwm_counter = 0;

  
  always @(posedge clk)  pwm_counter = 1+pwm_counter;
  reg  [27-1:0]  fade_counter = 0;

  
  always @(posedge clk)
      if (trigger) fade_counter = 0-1;
      else if (|fade_counter) fade_counter = (0-1)+fade_counter;
        
  wire [LEVEL_BITS+(0-1):0] level;

  assign level = fade_counter[27-1:27+(-LEVEL_BITS)];
  assign drive = pwm_counter < level;
endmodule

