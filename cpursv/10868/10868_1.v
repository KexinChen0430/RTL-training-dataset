
module e203_clkgate(input  clk_in,
                    input  test_mode,
                    input  clock_en,
                    output clk_out);

  reg  enb;

  
  always @(*)
      if (!clk_in) enb = test_mode | clock_en;
        
  assign clk_out = clk_in & enb;
endmodule

