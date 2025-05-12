module spc_master ( Clk, Reset, Input_i, Start_i, NumDatNibble_i,
        LengthTrigger_i, LengthTimeout_i, MinSync_i, Out_o, DataOut_o,
        NewData_o, CrcOk_o, SPCReady_o, ScanEnable_i, ScanClk_i, ScanDataIn_i,
        ScanDataOut_o );
  parameter MaxDatNibble_g = 6;
  parameter CountWidth_g = 16;
  parameter TimeoutWidth_g = 16;
  parameter UseTimeout_g = 1;
  input [2:0] NumDatNibble_i;  
  input [(CountWidth_g-1):0] LengthTrigger_i;
  input [(CountWidth_g-1):0] MinSync_i;
  output [(MaxDatNibble_g*4+3):0] DataOut_o;
  input [(TimeoutWidth_g-1):0] LengthTimeout_i;
  input Clk, Reset, Input_i, Start_i, ScanEnable_i, ScanClk_i, ScanDataIn_i;
  output Out_o, NewData_o, CrcOk_o, SPCReady_o, ScanDataOut_o;
endmodule