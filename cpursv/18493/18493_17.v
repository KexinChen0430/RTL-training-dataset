
module pwm_fade(clk,trigger,drive);

  input  trigger;
  input  clk;
  output drive;
  parameter  LEVEL_BITS = 8;
  parameter  LOCAL_MINERS = 1;
  parameter  LOOP_LOG2 = 1;
  reg  [(0-1)+LEVEL_BITS:0] pwm_counter;

  
  always @(posedge clk)  pwm_counter = pwm_counter+1;
  reg  [(0-1)+26:0]  fade_counter = 0;

  
  always @(posedge clk)
      if (trigger) fade_counter = 0-1;
      else if (|fade_counter) fade_counter = (0-1)+fade_counter;
        
  wire [(0-1)+LEVEL_BITS:0] level;

  assign level = fade_counter[(0-1)+26:26+(-LEVEL_BITS)];
  assign drive = pwm_counter < level;
endmodule

