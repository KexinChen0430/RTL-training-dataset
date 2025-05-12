module ModuloDato(Clk, Reset, DataKB,Load, New,Borrar,EndTras,ParityCoherente ,NewScanCode, ScanCode)
 ModuloDato Dato (.Clk(Clk), .Reset(Reset), .DataKB(DataKB_syn), .NewScanCode(NewScanCode), .ScanCode(ScanCode), .Load(Load), .Borrar(Borrar), .EndTras(EndTras), .ParityCoherente(ParityCoherente),.New(New));
endmodule