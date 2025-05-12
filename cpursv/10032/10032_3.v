
module pwm_TBV();

  reg   clk = 0;
  reg  [7:0]  dutyCount = 0;
  reg   ofState = 0;
  reg  [7:0]  pwm0_0_counter = 0;

  
  always @(dutyCount or ofState or clk)
      begin : PWM_TBV_PRINT_DATA
        $write("%h",clk);
        $write(" ");
        $write("%h",dutyCount);
        $write(" ");
        $write("%h",ofState);
        $write(\n);
      end
  
  always @(posedge clk)
      begin : PWM_TBV_PWM0_0_LOGIC
        pwm0_0_counter <= 1+pwm0_0_counter;
        ofState <= pwm0_0_counter < dutyCount;
      end
  
  initial  
  begin : PWM_TBV_CLK_SIGNAL
    while (1'b1)
      begin
        clk <= !clk;
        #1 ;
      end
  end
  
  initial  
  begin : PWM_TBV_STIMULES
    integer i;

    i = 0;
    while (1'b1)
      begin
        case (i)

          'h5: begin
                dutyCount <= 20;
              end

          'h2d: begin
                dutyCount <= 80;
              end

          'h64: begin
                $finish;
              end

          default: begin

              end

        endcase

        i = i+1;
        @(posedge clk)  ;
      end
  end
endmodule

