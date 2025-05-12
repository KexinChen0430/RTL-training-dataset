
module BDCLed_TBV();

  reg   clk = 0;
  wire [1:0] sw;
  reg  [3:0]  led = 0;
  wire [7:0] BDCLed0_0_duty_led;
  reg  [7:0]  BDCLed0_0_counter = 0;

  assign sw = 2'd0;
  assign BDCLed0_0_duty_led = 8'd8;
  
  always @(led or sw or clk)
      begin : BDCLED_TBV_PRINT_DATA
        $write("%h",sw);
        $write(" ");
        $write("%h",clk);
        $write(" ");
        $write("%h",led);
        $write(\n);
      end
  
  always @(posedge clk)
      begin : BDCLED_TBV_BDCLED0_0_LOGIC
        BDCLed0_0_counter <= 1+BDCLed0_0_counter;
        if (BDCLed0_0_counter < BDCLed0_0_duty_led) 
          begin
            led <= 15;
          end
        else 
          begin
            led <= 0;
          end
      end
  
  initial  
  begin : BDCLED_TBV_CLK_SIGNAL
    while (1'b1)
      begin
        clk <= !clk;
        #1 ;
      end
  end
  
  initial  
  begin : BDCLED_TBV_STIMULES
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

