module pwm_master ( 
  Clk, 
  Reset, 
  Polarity_i, 
  Input_i, 
  Value_o, 
  NewValue_o, 
  ScanEnable_i, 
  ScanClk_i, 
  ScanDataIn_i, 
  ScanDataOut_o 
);
  parameter Resolution_g = 12;
  parameter CounterWidth_g = 20;
  output [(Resolution_g-1):0] Value_o;
  input Clk, Reset, Polarity_i, Input_i, ScanEnable_i, ScanClk_i, ScanDataIn_i;
  output NewValue_o, ScanDataOut_o;
endmodule