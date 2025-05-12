module DigiMic_Interface(
    CLK, 
    DesiredDMMemoryLocationToRead, 
    DMLocationWritingTo, 
    SampleDelayZero, 
    DesiredDMInterfaceOutput, 
    DMCLK, 
    DMDATA1, 
    DMDATA2, 
    DMDATA3, 
    DMDATA4, 
    DesiredDM 
);
input          CLK, DMDATA1, DMDATA2, DMDATA3, DMDATA4;
input  [1:0]   DesiredDM;
input  [9:0]   DesiredDMMemoryLocationToRead;
output         DMCLK, SampleDelayZero;
output [9:0]   DMLocationWritingTo;
output [8:0]   DesiredDMInterfaceOutput;
reg [8:0]      DMAdder1, DMAdder2, DMAdder3, DMAdder4;
reg [9:0]      DMLocationWritingTo;
reg [8:0]      DesiredDMInterfaceOutput1, DesiredDMInterfaceOutput2, DesiredDMInterfaceOutput3, DesiredDMInterfaceOutput4;
reg [12:0]     SampleDelayCount;
wire           DMCLK, DMDATA1, DMDATA2, DMDATA3, DMDATA4, SampleDelayZero;
wire [1:0]     DesiredDM;
reg [8:0]      DesiredDMInterfaceOutput;
(* RAM_STYLE="{auto | block |  block_power1 | block_power2}" *)
reg [8:0]      StoredDMValues1 [1023:0]; 
(* RAM_STYLE="{auto | block |  block_power1 | block_power2}" *)
reg [8:0]      StoredDMValues2 [1023:0]; 
(* RAM_STYLE="{auto | block |  block_power1 | block_power2}" *)
reg [8:0]      StoredDMValues3 [1023:0]; 
(* RAM_STYLE="{auto | block |  block_power1 | block_power2}" *)
reg [8:0]      StoredDMValues4 [1023:0]; 
assign   DMCLK = SampleDelayCount[3];
assign SampleDelayZero = ~| SampleDelayCount;
always @(posedge CLK)
begin
  SampleDelayCount <= SampleDelayCount + 1;
end
always @(posedge CLK)
begin
  if (SampleDelayZero)
  begin
    DMLocationWritingTo <= DMLocationWritingTo + 1;
  end
end
assign    DMRead = (SampleDelayCount[3] && SampleDelayCount[2] && SampleDelayCount[1] && !SampleDelayCount[0]);
always @(posedge CLK)
begin
  if (DMRead || SampleDelayZero)
  begin
    if (SampleDelayZero)
    begin
      DMAdder1 <= 0;
    end
    else
    begin
      DMAdder1 <= DMAdder1 + DMDATA1;
    end
  end
end
always @(posedge CLK)
begin
  if (SampleDelayZero)
  begin
    StoredDMValues1[DMLocationWritingTo] <= DMAdder1[8:0];
  end
  DesiredDMInterfaceOutput1[8:0] <= StoredDMValues1[DesiredDMMemoryLocationToRead];
end
always @(DesiredDM or DesiredDMInterfaceOutput1 or DesiredDMInterfaceOutput2 or DesiredDMInterfaceOutput3 or DesiredDMInterfaceOutput4)
begin
  case (DesiredDM)
    2'b00   : begin
               DesiredDMInterfaceOutput = DesiredDMInterfaceOutput1;
             end
    2'b01   : begin
               DesiredDMInterfaceOutput = DesiredDMInterfaceOutput2;
             end
    2'b10   : begin
               DesiredDMInterfaceOutput = DesiredDMInterfaceOutput3;
             end
    2'b11   : begin
               DesiredDMInterfaceOutput = DesiredDMInterfaceOutput4;
             end
    default: begin
               DesiredDMInterfaceOutput = 9'b0000_0000_0;
             end
  endcase
end
endmodule