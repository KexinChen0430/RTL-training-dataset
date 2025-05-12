
module top(hwclk,led1,keypad_r1,keypad_c1);

  input  hwclk;
  output led1;
  output  keypad_r1 = 0;
  input  keypad_c1;
  reg   ledval = 1'b0;
  wire keypad_c1_din;

  SB_IO #(.PIN_TYPE(6'b0000_01),.PULLUP(1'b1)) keypad_c1_config(.PACKAGE_PIN(keypad_c1),
                                                                .D_IN_0(keypad_c1_din));
  reg  [31:0]  debounce_timer = 32'b0;

  parameter  DEBOUNCE_PERIOD = 32'd120000;

  reg   debouncing = 1'b0;

  assign led1 = ledval;
  
  always @(posedge hwclk)
      begin
        if (~keypad_c1_din && ~debouncing) 
          begin
            ledval <= ~ledval;
            debouncing <= 1;
          end
        else if (debouncing && ~keypad_c1_din) 
          begin
            debounce_timer <= 32'b0;
          end
        else if ((debounce_timer < DEBOUNCE_PERIOD) && debouncing) 
          begin
            debounce_timer <= debounce_timer+1;
          end
        else if (debouncing) 
          begin
            debounce_timer <= 32'b0;
            debouncing <= 1'b0;
          end
          
      end
endmodule

