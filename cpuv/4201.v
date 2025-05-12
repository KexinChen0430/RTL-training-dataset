module m0(clk, key, rstn, leds);
  parameter width=8;
  input clk;
  input key;
  input rstn;
  output reg [width-1:0] leds;
  reg [width-1:0] r0;
  initial begin
    leds = 0;
    r0 = 0;
  end
  always @(negedge key, negedge rstn) begin
    if (rstn == 0)
      r0 = {width{1'b0}};
    else
      r0 = r0 + {{width-1{1'b0}}, 1'b1};
  end
  always @(posedge clk) begin
    if (rstn == 0)
      leds <= {width{1'b0}};
    else
      leds <= r0;
  end
endmodule