module endpMux (
);
input clk; 
input rst; 
input [3:0] currEndP; 
input NAKSent; 
input stallSent; 
input CRCError; 
input bitStuffError; 
input RxOverflow; 
input RxTimeOut; 
input dataSequence; 
input ACKRxed; 
input [1:0] transType; 
input [1:0] transTypeNAK; 
output [4:0] endPControlReg; 
input clrEPRdy; 
input endPMuxErrorsWEn; 
input [4:0] endP0ControlReg;
input [4:0] endP1ControlReg;
input [4:0] endP2ControlReg;
input [4:0] endP3ControlReg;
output [7:0] endP0StatusReg;
output [7:0] endP1StatusReg;
output [7:0] endP2StatusReg;
output [7:0] endP3StatusReg;
output [1:0] endP0TransTypeReg;
output [1:0] endP1TransTypeReg;
output [1:0] endP2TransTypeReg;
output [1:0] endP3TransTypeReg;
output [1:0] endP0NAKTransTypeReg;
output [1:0] endP1NAKTransTypeReg;
output [1:0] endP2NAKTransTypeReg;
output [1:0] endP3NAKTransTypeReg;
output clrEP0Rdy;
output clrEP1Rdy;
output clrEP2Rdy;
output clrEP3Rdy;
always @(posedge clk) begin
end
always @(posedge clk) begin
  if (rst) begin
  end else begin
    if (endPMuxErrorsWEn == 1'b1) begin
      if (NAKSent == 1'b1) begin
      end else begin
      end
    end
  end
end
always @(dataSequence or ACKRxed or stallSent or RxTimeOut or RxOverflow or bitStuffError or CRCError) begin
  endPStatusCombine <= {dataSequence, ACKRxed, stallSent, 1'b0, RxTimeOut, RxOverflow, bitStuffError, CRCError};
end
endmodule