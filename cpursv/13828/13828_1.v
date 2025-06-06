
module top_TBV();

  reg   clk = 0;
  wire [3:0] led;
  wire [7:0] top0_0_pwm0_0_1_2_dutyCount;
  reg  [7:0]  top0_0_pwm0_0_1_2_counter = 0;
  wire [7:0] top0_0_pwm1_0_1_dutyCount;
  reg  [7:0]  top0_0_pwm1_0_1_counter = 0;
  wire [7:0] top0_0_pwm2_0_dutyCount;
  reg  [7:0]  top0_0_pwm2_0_counter = 0;
  wire [7:0] top0_0_pwm3_0_dutyCount;
  reg  [7:0]  top0_0_pwm3_0_counter = 0;
  reg  top0_0_led_i[0:4-1];

  
  initial  
  begin : INITIALIZE_TOP0_0_LED_I
    integer i;

    for (i = 0; i < 4; i = 1+i)
        begin
          top0_0_led_i[i] = 0;
        end
  end
  assign top0_0_pwm0_0_1_2_dutyCount = 8'd4;
  assign top0_0_pwm1_0_1_dutyCount = 8'd16;
  assign top0_0_pwm2_0_dutyCount = 8'd64;
  assign top0_0_pwm3_0_dutyCount = 8'd255;
  
  always @(led or clk)
      begin : TOP_TBV_PRINT_DATA
        $write("%h",clk);
        $write(" ");
        $write("%h",led);
        $write(\n);
      end
  
  always @(posedge clk)
      begin : TOP_TBV_TOP0_0_PWM0_0_1_2_LOGIC
        top0_0_pwm0_0_1_2_counter <= top0_0_pwm0_0_1_2_counter+1;
        top0_0_led_i[0] <= top0_0_pwm0_0_1_2_counter < top0_0_pwm0_0_1_2_dutyCount;
      end
  
  always @(posedge clk)
      begin : TOP_TBV_TOP0_0_PWM1_0_1_LOGIC
        top0_0_pwm1_0_1_counter <= 1+top0_0_pwm1_0_1_counter;
        top0_0_led_i[1] <= top0_0_pwm1_0_1_counter < top0_0_pwm1_0_1_dutyCount;
      end
  
  always @(posedge clk)
      begin : TOP_TBV_TOP0_0_PWM2_0_LOGIC
        top0_0_pwm2_0_counter <= 1+top0_0_pwm2_0_counter;
        top0_0_led_i[1<<1] <= top0_0_pwm2_0_counter < top0_0_pwm2_0_dutyCount;
      end
  
  always @(posedge clk)
      begin : TOP_TBV_TOP0_0_PWM3_0_LOGIC
        top0_0_pwm3_0_counter <= top0_0_pwm3_0_counter+1;
        top0_0_led_i[3] <= top0_0_pwm3_0_counter < top0_0_pwm3_0_dutyCount;
      end
  assign led = {top0_0_led_i[3],top0_0_led_i[1<<1],top0_0_led_i[1],top0_0_led_i[0]};
  
  initial  
  begin : TOP_TBV_CLK_SIGNAL
    while (1'b1)
      begin
        clk <= !clk;
        #1 ;
      end
  end
  
  initial  
  begin : TOP_TBV_STIMULES
    integer i;

    i = 0;
    while (1'b1)
      begin
        if (i == 1000) 
          begin
            $finish;
          end
          
        i = 1+i;
        @(posedge clk)  ;
      end
  end
endmodule

