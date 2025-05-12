
module e203_clkgate(input  clk_in,
                    input  test_mode,
                    input  clock_en,
                    output clk_out);

  reg  enb;

  
  always @(*)
      if (!clk_in) enb = clock_en | test_mode;
        
  assign clk_out = enb & clk_in;
endmodule

