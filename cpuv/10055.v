module TxfifoBI (
  address, writeEn, strobe_i,
  busClk,
  usbClk,
  rstSyncToBusClk,
  fifoSelect,
  busDataIn,
  busDataOut,
  fifoWEn,
  forceEmptySyncToUsbClk,
  forceEmptySyncToBusClk,
  numElementsInFifo
);
input [2:0] address; 
input writeEn; 
input strobe_i; 
input busClk; 
input usbClk; 
input rstSyncToBusClk; 
input [7:0] busDataIn; 
output [7:0] busDataOut; 
output fifoWEn; 
output forceEmptySyncToUsbClk; 
output forceEmptySyncToBusClk; 
input [15:0] numElementsInFifo; 
input fifoSelect; 
wire [2:0] address;
wire writeEn;
wire strobe_i;
wire busClk;
wire usbClk;
wire rstSyncToBusClk;
wire [7:0] busDataIn;
wire [7:0] busDataOut;
reg fifoWEn; 
wire forceEmptySyncToUsbClk;
wire forceEmptySyncToBusClk;
wire [15:0] numElementsInFifo;
wire fifoSelect;
reg forceEmptyReg; 
reg forceEmpty; 
reg forceEmptyToggle; 
reg [2:0] forceEmptyToggleSyncToUsbClk; 
always @(posedge busClk)
begin
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
  end
  else begin
    if (forceEmpty == 1'b1)
      forceEmptyReg <= 1'b1; 
    else
      forceEmptyReg <= 1'b0; 
    if (forceEmpty == 1'b1 && forceEmptyReg == 1'b0)
      forceEmptyToggle <= ~forceEmptyToggle; 
  end
end
assign forceEmptySyncToBusClk = (forceEmpty == 1'b1 && forceEmptyReg == 1'b0) ? 1'b1 : 1'b0;
always @(posedge usbClk) begin
    forceEmptyToggleSyncToUsbClk <= {forceEmptyToggleSyncToUsbClk[1:0], forceEmptyToggle}; 
end
assign forceEmptySyncToUsbClk = forceEmptyToggleSyncToUsbClk[2] ^ forceEmptyToggleSyncToUsbClk[1];
assign busDataOut = 8'h00; 
always @(address or writeEn or strobe_i or fifoSelect or busDataIn) begin
  if (address == `FIFO_DATA_REG && writeEn == 1'b1 &&
  strobe_i == 1'b1 && fifoSelect == 1'b1)
    fifoWEn <= 1'b1; 
  else
    fifoWEn <= 1'b0; 
end
endmodule 