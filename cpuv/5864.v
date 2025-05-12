module system_ov7670_controller_0_0(clk, resend, config_finished, sioc, siod, reset,
  pwdn, xclk)
;
  input clk;
  input resend;
  output config_finished;
  output sioc;
  inout siod;
  output reset;
  output pwdn;
  output xclk;
endmodule