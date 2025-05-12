module system_axi_quad_spi_flash_0(
  ext_spi_clk, 
  s_axi_aclk, 
  s_axi_aresetn, 
  s_axi_awaddr, 
  s_axi_awvalid, 
  s_axi_awready, 
  s_axi_wdata, 
  s_axi_wstrb, 
  s_axi_wvalid, 
  s_axi_wready, 
  s_axi_bresp, 
  s_axi_bvalid, 
  s_axi_bready, 
  s_axi_araddr, 
  s_axi_arvalid, 
  s_axi_arready, 
  s_axi_rdata, 
  s_axi_rresp, 
  s_axi_rvalid, 
  s_axi_rready, 
  io0_i, 
  io0_o, 
  io0_t, 
  io1_i, 
  io1_o, 
  io1_t, 
  io2_i, 
  io2_o, 
  io2_t, 
  io3_i, 
  io3_o, 
  io3_t, 
  sck_i, 
  sck_o, 
  sck_t, 
  ss_i, 
  ss_o, 
  ss_t, 
  ip2intc_irpt 
) ;
  input ext_spi_clk;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [6:0] s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0] s_axi_wdata;
  input [3:0] s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [6:0] s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  input io0_i;
  output io0_o;
  output io0_t;
  input io1_i;
  output io1_o;
  output io1_t;
  input io2_i;
  output io2_o;
  output io2_t;
  input io3_i;
  output io3_o;
  output io3_t;
  input sck_i;
  output sck_o;
  output sck_t;
  input [0:0] ss_i;
  output [0:0] ss_o;
  output ss_t;
  output ip2intc_irpt;
endmodule