
module radio_bridge();

  input  converter_clock_in;
  output converter_clock_out;
  input  user_RSSI_ADC_clk;
  output radio_RSSI_ADC_clk;
  output [0:9] user_RSSI_ADC_D;
  input  user_EEPROM_IO_T;
  input  user_EEPROM_IO_O;
  output user_EEPROM_IO_I;
  output [0:15] radio_DAC_I;
  output [0:15] radio_DAC_Q;
  input  [0:13] radio_ADC_I;
  input  [0:13] radio_ADC_Q;
  input  [0:15] user_DAC_I;
  input  [0:15] user_DAC_Q;
  output [0:13] user_ADC_I;
  output [0:13] user_ADC_Q;
  input  [0:1] user_RxRF_gain;
  input  [0:4] user_RxBB_gain;
  input  [0:5] user_Tx_gain;
  output [0:6] radio_B;
  reg  [0:6] radio_B;

  assign converter_clock_out = converter_clock_in;
  assign radio_RSSI_ADC_clk = user_RSSI_ADC_clk;
  assign user_ADC_I = radio_ADC_I;
  assign user_ADC_Q = radio_ADC_Q;
  assign radio_DAC_I = user_DAC_I;
  assign radio_DAC_Q = user_DAC_Q;
  wire [0:6] radio_B_preReg;

  assign radio_B_preReg = controller_RxEn ? {user_RxRF_gain,user_RxBB_gain} : {1'b0,user_Tx_gain};
  
  always @(posedge converter_clock_in)
      begin
        radio_B <= radio_B_preReg;
      end
  IOBUF xIOBUF(.T(user_EEPROM_IO_T),.I(user_EEPROM_IO_O),
               .O(user_EEPROM_IO_I),.IO(radio_EEPROM_IO));
endmodule

