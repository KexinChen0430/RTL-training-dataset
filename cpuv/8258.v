module DPRAM64_for_RAM128X1D (
  output O,
  input  DI, CLK, WE, WA7,
  input [5:0] A, WA
);
  parameter [63:0] INIT = 64'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  parameter HIGH_WA7_SELECT = 1'b0;
  wire [5:0] A;
  wire [5:0] WA;
  reg [63:0] mem;
  initial mem <= INIT;
  assign O = mem[A];
  wire clk = CLK ^ IS_WCLK_INVERTED;
  always @(posedge clk) if (WE & (WA7 == HIGH_WA7_SELECT)) mem[WA] <= DI;
endmodule