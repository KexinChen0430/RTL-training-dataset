module sync_2rd_2wr (
  input clk,
  input [7:0] ra0,
  input [7:0] ra1,
  input [7:0] wa0,
  input [7:0] wa1,
  input [1:0] we,
  input [1:0] re,
  input [15:0] d0,
  input [15:0] d1,
  output reg [15:0] q0,
  output reg [15:0] q1
);
  reg [15:0] mem[0:255];
  integer i;
  always @(posedge clk) begin
    if (we0) mem[wa0] <= d0;
    if (we1) mem[wa1] <= d1;
  end
  always @(posedge clk) if (re[0]) q0 <= mem[ra0];
  always @(posedge clk) if (re[1]) q1 <= mem[ra1];
endmodule