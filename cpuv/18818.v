module stim (input clk, reset, output reg [2:0] count, output reg en);
  always @(posedge clk) begin
    if (reset) count <= 3'b0;
    else       count <= count + 1;
  end
  initial begin
    en = 1;
    repeat (100) @(posedge clk);
    en = 0;
  end
endmodule