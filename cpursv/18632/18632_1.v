
module cyclone10gx_clkena(inclk,ena,enaout,outclk);

  parameter  clock_type = auto;
  parameter  ena_register_mode = "always enabled";
  parameter  lpm_type = cyclone10gx_clkena;
  parameter  ena_register_power_up = high;
  parameter  disable_mode = low;
  parameter  test_syn = high;
  input  inclk;
  input  ena;
  output enaout;
  output outclk;


endmodule

