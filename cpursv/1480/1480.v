
module system_zed_hdmi_0_0(clk,clk_x2,clk_100,active,hsync,vsync,rgb888,hdmi_clk,
                           hdmi_hsync,hdmi_vsync,hdmi_d,hdmi_de,hdmi_scl,hdmi_sda);

   ;
  input  clk;

  input  clk_x2;

  input  clk_100;

  input  active;

  input  hsync;

  input  vsync;

  input  [23:0] rgb888;

  output hdmi_clk;

  output hdmi_hsync;

  output hdmi_vsync;

  output [15:0] hdmi_d;

  output hdmi_de;

  output hdmi_scl;

  inout  hdmi_sda;

endmodule

