module design_1_pointer_basic_0_1(s_axi_pointer_basic_io_AWADDR,
  s_axi_pointer_basic_io_AWVALID, s_axi_pointer_basic_io_AWREADY,
  s_axi_pointer_basic_io_WDATA, s_axi_pointer_basic_io_WSTRB,
  s_axi_pointer_basic_io_WVALID, s_axi_pointer_basic_io_WREADY,
  s_axi_pointer_basic_io_BRESP, s_axi_pointer_basic_io_BVALID,
  s_axi_pointer_basic_io_BREADY, s_axi_pointer_basic_io_ARADDR,
  s_axi_pointer_basic_io_ARVALID, s_axi_pointer_basic_io_ARREADY,
  s_axi_pointer_basic_io_RDATA, s_axi_pointer_basic_io_RRESP,
  s_axi_pointer_basic_io_RVALID, s_axi_pointer_basic_io_RREADY, ap_clk, ap_rst_n,
  interrupt)
;
  input [4:0]s_axi_pointer_basic_io_AWADDR;
  input s_axi_pointer_basic_io_AWVALID;
  output s_axi_pointer_basic_io_AWREADY;
  input [31:0]s_axi_pointer_basic_io_WDATA;
  input [3:0]s_axi_pointer_basic_io_WSTRB;
  input s_axi_pointer_basic_io_WVALID;
  output s_axi_pointer_basic_io_WREADY;
  output [1:0]s_axi_pointer_basic_io_BRESP;
  output s_axi_pointer_basic_io_BVALID;
  input s_axi_pointer_basic_io_BREADY;
  input [4:0]s_axi_pointer_basic_io_ARADDR;
  input s_axi_pointer_basic_io_ARVALID;
  output s_axi_pointer_basic_io_ARREADY;
  output [31:0]s_axi_pointer_basic_io_RDATA;
  output [1:0]s_axi_pointer_basic_io_RRESP;
  output s_axi_pointer_basic_io_RVALID;
  input s_axi_pointer_basic_io_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
endmodule