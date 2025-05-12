module sent_master ( Clk, Reset, Chipselect_i, NumDatNibble_i, Input_i,
        MinSync_i, Out_o, NewData_o, CrcOk_o, ScanEnable_i, ScanClk_i,
        ScanDataIn_i, ScanDataOut_o );
  parameter MaxDatNibble_g = 6;
  parameter CountWidth_g = 16;
  input [2:0] NumDatNibble_i;  
  input [(CountWidth_g-1):0] MinSync_i;
  output [(MaxDatNibble_g*4+3):0] Out_o;
  input Clk, Reset, Chipselect_i, Input_i, ScanEnable_i, ScanClk_i,
         ScanDataIn_i;
  output NewData_o, CrcOk_o, ScanDataOut_o;
endmodule