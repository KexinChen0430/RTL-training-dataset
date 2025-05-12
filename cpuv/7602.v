module crc16(reset, crcinclk, crcbitin, crcoutclk, crcbitout, crcdone); 
input reset, crcinclk, crcbitin, crcoutclk; 
output crcbitout, crcdone; 
reg [15:0] crc; 
reg [3:0] bitoutcounter; 
wire crcdone; 
assign crcbitout = crc[~bitoutcounter]; 
assign crcdone = (bitoutcounter == 15); 
always @ (posedge crcoutclk or posedge reset) begin 
  if (reset) begin
    bitoutcounter <= 0; 
  end else if (!crcdone) begin
    bitoutcounter <= bitoutcounter + 4'd1; 
  end
end
always @ (posedge crcinclk or posedge reset) begin 
  if (reset) begin
    crc     <= 'h0000; 
  end else begin
  end
end
endmodule 