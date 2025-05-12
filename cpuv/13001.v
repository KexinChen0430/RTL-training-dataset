module pipeline_0_latch(clk, iaddrbusWire1, iaddrbusOut, reset);
  input clk, reset;
  input [31:0] iaddrbusWire1;
  output [31:0] iaddrbusOut;
  reg [31:0] iaddrbusOut;
  reg startBit;
  initial begin
  startBit = 1;
  end
  always@(posedge clk) begin
    iaddrbusOut = (reset|startBit)? 0:iaddrbusWire1+4;
    startBit = 0;
  end
endmodule