module lineControlUpdate(fullSpeedPolarity, fullSpeedBitRate, JBit, KBit);
input fullSpeedPolarity;
input fullSpeedBitRate;
output [1:0] JBit;
output [1:0] KBit;
wire fullSpeedPolarity;
wire fullSpeedBitRate;
reg [1:0] JBit;
reg [1:0] KBit;
always @(fullSpeedPolarity)
begin
    if (fullSpeedPolarity == 1'b1)
  begin
      JBit = `ONE_ZERO;
      KBit = `ZERO_ONE;
    end
    else
  begin
      JBit = `ZERO_ONE;
      KBit = `ONE_ZERO;
    end
end
endmodule