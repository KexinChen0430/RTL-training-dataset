module RxfifoBI (
  input [2:0] address,                
  input writeEn,                      
  input strobe_i,                     
  input busClk,                       
  input usbClk,                       
  input rstSyncToBusClk,              
  input [7:0] fifoDataIn,             
  input [7:0] busDataIn,              
  output reg [7:0] busDataOut,        
  output reg fifoREn,                 
  output forceEmptySyncToUsbClk,      
  output forceEmptySyncToBusClk,      
  input [15:0] numElementsInFifo,     
  input fifoSelect                    
);
reg forceEmptyReg;                    
reg forceEmpty;                       
reg forceEmptyToggle;                 
reg [2:0] forceEmptyToggleSyncToUsbClk; 
always @(posedge busClk) begin
  if (writeEn == 1'b1 && fifoSelect == 1'b1 &&
      address == `FIFO_CONTROL_REG && strobe_i == 1'b1 && busDataIn[0] == 1'b1)
    forceEmpty <= 1'b1;
  else
    forceEmpty <= 1'b0;
end
always @(posedge busClk) begin
  if (rstSyncToBusClk == 1'b1) begin
    forceEmptyReg <= 1'b0;
    forceEmptyToggle <= 1'b0;
  end else begin
    forceEmptyReg <= forceEmpty;
    if (forceEmpty == 1'b1 && forceEmptyReg == 1'b0)
      forceEmptyToggle <= ~forceEmptyToggle;
  end
end
assign forceEmptySyncToBusClk = (forceEmpty == 1'b1 && forceEmptyReg == 1'b0) ? 1'b1 : 1'b0;
always @(posedge usbClk) begin
    forceEmptyToggleSyncToUsbClk <= {forceEmptyToggleSyncToUsbClk[1:0], forceEmptyToggle};
end
assign forceEmptySyncToUsbClk = forceEmptyToggleSyncToUsbClk[2] ^ forceEmptyToggleSyncToUsbClk[1];
always @(*) begin
  case (address)
      `FIFO_DATA_REG : busDataOut <= fifoDataIn;
      `FIFO_DATA_COUNT_MSB : busDataOut <= numElementsInFifo[15:8];
      `FIFO_DATA_COUNT_LSB : busDataOut <= numElementsInFifo[7:0];
      default: busDataOut <= 8'h00;
  endcase
end
always @(posedge busClk) begin
  if (address == `FIFO_DATA_REG && writeEn == 1'b0 &&
      strobe_i == 1'b1 && fifoSelect == 1'b1)
    fifoREn <= 1'b1;
  else
    fifoREn <= 1'b0;
end
endmodule