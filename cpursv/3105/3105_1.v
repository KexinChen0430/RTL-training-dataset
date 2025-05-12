
module clkgen(input  sys_clk_pad_i,
              input  rst_n_pad_i,
              output async_rst_o,
              output wb_clk_o,
              output wb_rst_o,
              output ddr2_if_clk_o,
              output ddr2_if_rst_o);

  wire async_rst_n;

  assign async_rst_n = ~rst_n_pad_i;
  reg  rst_r;

  reg  wb_rst_r;

  wire sync_ddr2_rst_n;

  wire sys_clk_pad_ibufg;

  wire dcm0_clk0_prebufg,dcm0_clk0;

  wire dcm0_clk90_prebufg,dcm0_clk90;

  wire dcm0_clkfx_prebufg,dcm0_clkfx;

  wire dcm0_clkdv_prebufg,dcm0_clkdv;

  wire dcm0_locked;

  IBUFG sys_clk_in_ibufg(.I(sys_clk_pad_i),.O(sys_clk_pad_ibufg));
  DCM_SP #(.CLKFX_MULTIPLY(4),.CLKFX_DIVIDE(1),.CLKIN_PERIOD(20.),
.CLKDV_DIVIDE(2.)) dcm0(.CLK0(dcm0_clk0_prebufg),
                                                                                           .CLK180(),.CLK270(),
                                                                                           .CLK2X180(),.CLK2X(),
                                                                                           .CLK90(),.CLKDV(dcm0_clkdv_prebufg),
                                                                                           .CLKFX180(),.CLKFX(dcm0_clkfx_prebufg),
                                                                                           .LOCKED(dcm0_locked),.CLKFB(dcm0_clk0),
                                                                                           .CLKIN(sys_clk_pad_ibufg),.PSEN(1'b0),
                                                                                           .RST(1'b0));
  BUFG dcm0_clk0_bufg(.O(dcm0_clk0),.I(dcm0_clk0_prebufg));
  BUFG dcm0_clkfx_bufg(.O(dcm0_clkfx),.I(dcm0_clkfx_prebufg));
  BUFG dcm0_clkdv_bufg(.O(dcm0_clkdv),.I(dcm0_clkdv_prebufg));
  assign wb_clk_o = dcm0_clkdv;
  assign sync_ddr2_rst_n = dcm0_locked;
  assign ddr2_if_clk_o = dcm0_clkfx;
  
  always @(posedge wb_clk_o or negedge async_rst_n)
      if (~async_rst_n) rst_r <= 1'b1;
      else rst_r <= #1 1'b0;
  assign async_rst_o = rst_r;
  
  always @(posedge wb_clk_o)  wb_rst_r <= #1 async_rst_o;
  assign wb_rst_o = wb_rst_r;
  assign ddr2_if_rst_o = async_rst_o;
endmodule

