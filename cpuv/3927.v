module onewire_master ( Clk, Reset, OWIn_i, OWOut_o,
        OWReset_i, DeactivateOverdriveMode_i, SearchROM_i, ReadROM_i,
        MatchROM_i, SkipROM_i, CondSearchROM_i, OverdriveSkipROM_i,
        OverdriveMatchROM_i, CondReadROM_i, ResumeROM_i, WriteByte_i,
        ReadByte_i, GetROMID_i, Data_i, Data_o, ROMIDsInArray_o, Noslaves_o,
        ROMIDArrayToSmall_o, PDROut_o, Ready_o, ResetLowTime, ResetTime,
        ResetWaitForDetectionDuration, ResetPrecenceIntervalDuration,
        WRSlotHighDataTime, RDSlotSampleTime, SlotLowDataTime, SlotDuration,
        RDSlotInitTime, ODResetLowTime, ODResetTime,
        ODResetWaitForDetectionDuration, ODResetPrecenceIntervalDuration,
        ODWRSlotHighDataTime, ODRDSlotSampleTime, ODSlotLowDataTime,
        ODSlotDuration, ODRDSlotInitTime, ScanEnable_i, ScanClk_i,
        ScanDataIn_i, ScanDataOut_o );
  parameter ROMIDArraySize = 4;
  parameter ROMIDIndexSize = 2;
  parameter ROMIDByteIndexSize = 3;
  parameter SearchCommand = 'hF0;
  parameter CondSearchCommand = 'hEC;
  parameter MatchCommand = 'h55;
  parameter ReadCommand = 'h33;
  parameter SkipCommand = 'hCC;
  parameter OverdriveSkipCommand = 'h3C;
  parameter OverdriveMatchCommand = 'h69;
  parameter ConditionalReadCommand = 'h0F;
  parameter ResumeCommand = 'hA5;
  parameter TimerWidth = 16;
  input [7:0] Data_i;
  output [7:0] Data_o;
  output [(ROMIDIndexSize-1):0] ROMIDsInArray_o;
  input [(TimerWidth-1):0] ResetLowTime;
  input [(TimerWidth-1):0] ResetTime;
  input [(TimerWidth-1):0] ResetWaitForDetectionDuration;
  input [(TimerWidth-1):0] ResetPrecenceIntervalDuration;
  input [(TimerWidth-1):0] WRSlotHighDataTime;
  input [(TimerWidth-1):0] RDSlotSampleTime;
  input [(TimerWidth-1):0] SlotLowDataTime;
  input [(TimerWidth-1):0] SlotDuration;
  input [(TimerWidth-1):0] RDSlotInitTime;
  input [(TimerWidth-1):0] ODResetLowTime;
  input [(TimerWidth-1):0] ODResetTime;
  input [(TimerWidth-1):0] ODResetWaitForDetectionDuration;
  input [(TimerWidth-1):0] ODResetPrecenceIntervalDuration;
  input [(TimerWidth-1):0] ODWRSlotHighDataTime;
  input [(TimerWidth-1):0] ODRDSlotSampleTime;
  input [(TimerWidth-1):0] ODSlotLowDataTime;
  input [(TimerWidth-1):0] ODSlotDuration;
  input [(TimerWidth-1):0] ODRDSlotInitTime;
  input Clk, Reset, OWIn_i, OWReset_i, DeactivateOverdriveMode_i, SearchROM_i,
         ReadROM_i, MatchROM_i, SkipROM_i, CondSearchROM_i, OverdriveSkipROM_i,
         OverdriveMatchROM_i, CondReadROM_i, ResumeROM_i, WriteByte_i,
         ReadByte_i, GetROMID_i, ScanEnable_i, ScanClk_i, ScanDataIn_i;
  output OWOut_o, Noslaves_o, ROMIDArrayToSmall_o, PDROut_o, Ready_o,
         ScanDataOut_o;
endmodule