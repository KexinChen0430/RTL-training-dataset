module clock_gate_latch (gated_clk, clk, clken);
  output gated_clk;
  input clk, clken;
  reg clken_latched;
  assign gated_clk = clk & clken_latched;
  wire clkb = ~clk;
  always_latch @(clkb or clken)
    if(clkb) clken_latched = clken;
endmodule