
module oscillator_s1(OSC_CLK_EN,OSC_CLK);

  parameter  T_CYCLE_CLK = 1000.*(1/19.2);
  input  OSC_CLK_EN;
  output OSC_CLK;
  wire OSC_CLK_EN;
  wire OSC_CLK;
  reg  osc_int_clk;

  assign OSC_CLK = OSC_CLK_EN ? osc_int_clk : 1'bZ;
  
  initial  
  begin
    osc_int_clk = 0;
    forever begin
  #(T_CYCLE_CLK*(1/2)) osc_int_clk = 1;
  #(T_CYCLE_CLK*(1/2)) osc_int_clk = 0;
end
  end
endmodule

