module hostSlaveMuxBI (
    dataIn, dataOut, address, writeEn, strobe_i, busClk, usbClk,
    hostMode, hostSlaveMuxSel, rstFromWire, rstSyncToBusClkOut, rstSyncToUsbClkOut
);
input [7:0] dataIn;                
input address;                     
input writeEn;                     
input strobe_i;                    
input busClk;                      
input usbClk;                      
output [7:0] dataOut;              
input hostSlaveMuxSel;             
output hostMode;                   
input rstFromWire;                 
output rstSyncToBusClkOut;         
output rstSyncToUsbClkOut;         
wire [7:0] dataIn;
wire address;
wire writeEn;
wire strobe_i;
wire busClk;
wire usbClk;
reg [7:0] dataOut;
wire hostSlaveMuxSel;
reg hostMode;
wire rstFromWire;
reg rstSyncToBusClkOut;
reg rstSyncToUsbClkOut;
reg [5:0] rstShift;               
reg rstFromBus;                    
reg rstSyncToUsbClkFirst;         
always @(posedge busClk)
begin
    if (rstSyncToBusClkOut == 1'b1)
        hostMode <= 1'b0;
    else begin
        if (writeEn == 1'b1 && hostSlaveMuxSel == 1'b1 && strobe_i == 1'b1 && address == `HOST_SLAVE_CONTROL_REG)
            hostMode <= dataIn[0];
    end
    if (writeEn == 1'b1 && hostSlaveMuxSel == 1'b1 && strobe_i == 1'b1 && address == `HOST_SLAVE_CONTROL_REG && dataIn[1] == 1'b1)
        rstFromBus <= 1'b1;
    else
        rstFromBus <= 1'b0;
end
always @(address or hostMode)
begin
    case (address)
        `HOST_SLAVE_CONTROL_REG: dataOut <= {7'h0, hostMode};
        `HOST_SLAVE_VERSION_REG: dataOut <= `USBHOSTSLAVE_VERSION_NUM;
    endcase
end
always @(posedge busClk) begin
    if (rstFromWire == 1'b1 || rstFromBus == 1'b1)
        rstShift <= 6'b111111;
    else
        rstShift <= {1'b0, rstShift[5:1]};
end
always @(rstShift)
    rstSyncToBusClkOut <= rstShift[0];
always @(posedge usbClk) begin
    rstSyncToUsbClkFirst <= rstSyncToBusClkOut;
    rstSyncToUsbClkOut <= rstSyncToUsbClkFirst;
end
endmodule