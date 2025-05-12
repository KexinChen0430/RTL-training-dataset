
module clock_gate_flop(gated_clk,clk,clken);

  output gated_clk;
  input  clk,clken;
  reg  clken_r;

  assign gated_clk = clken_r & clk;
  
  always @(negedge clk)  clken_r <= clken;
endmodule

