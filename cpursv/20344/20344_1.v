
module m00_couplers_imp_ZVW4AE(input  M_ACLK,
                               input  M_ARESETN,
                               output [8:0] M_AXI_araddr,
                               input  M_AXI_arready,
                               output M_AXI_arvalid,
                               output [8:0] M_AXI_awaddr,
                               input  M_AXI_awready,
                               output M_AXI_awvalid,
                               output M_AXI_bready,
                               input  [1:0] M_AXI_bresp,
                               input  M_AXI_bvalid,
                               input  [31:0] M_AXI_rdata,
                               output M_AXI_rready,
                               input  [1:0] M_AXI_rresp,
                               input  M_AXI_rvalid,
                               output [31:0] M_AXI_wdata,
                               input  M_AXI_wready,
                               output [3:0] M_AXI_wstrb,
                               output M_AXI_wvalid,
                               input  S_ACLK,
                               input  S_ARESETN,
                               input  [8:0] S_AXI_araddr,
                               output S_AXI_arready,
                               input  S_AXI_arvalid,
                               input  [8:0] S_AXI_awaddr,
                               output S_AXI_awready,
                               input  S_AXI_awvalid,
                               input  S_AXI_bready,
                               output [1:0] S_AXI_bresp,
                               output S_AXI_bvalid,
                               output [31:0] S_AXI_rdata,
                               input  S_AXI_rready,
                               output [1:0] S_AXI_rresp,
                               output S_AXI_rvalid,
                               input  [31:0] S_AXI_wdata,
                               output S_AXI_wready,
                               input  [3:0] S_AXI_wstrb,
                               input  S_AXI_wvalid);

  wire [8:0] m00_couplers_to_m00_couplers_ARADDR;
  wire m00_couplers_to_m00_couplers_ARREADY;
  wire m00_couplers_to_m00_couplers_ARVALID;
  wire [8:0] m00_couplers_to_m00_couplers_AWADDR;
  wire m00_couplers_to_m00_couplers_AWREADY;
  wire m00_couplers_to_m00_couplers_AWVALID;
  wire m00_couplers_to_m00_couplers_BREADY;
  wire [1:0] m00_couplers_to_m00_couplers_BRESP;
  wire m00_couplers_to_m00_couplers_BVALID;
  wire [31:0] m00_couplers_to_m00_couplers_RDATA;
  wire m00_couplers_to_m00_couplers_RREADY;
  wire [1:0] m00_couplers_to_m00_couplers_RRESP;
  wire m00_couplers_to_m00_couplers_RVALID;
  wire [31:0] m00_couplers_to_m00_couplers_WDATA;
  wire m00_couplers_to_m00_couplers_WREADY;
  wire [3:0] m00_couplers_to_m00_couplers_WSTRB;
  wire m00_couplers_to_m00_couplers_WVALID;

  assign M_AXI_araddr[8:0] = m00_couplers_to_m00_couplers_ARADDR;
  assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID;
  assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY;
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[8:0];
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0];
  assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid[0];
  assign M_AXI_awaddr[8:0] = m00_couplers_to_m00_couplers_AWADDR;
  assign M_AXI_awvalid[0] = m00_couplers_to_m00_couplers_AWVALID;
  assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY;
  assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[8:0];
  assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready[0];
  assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid[0];
  assign M_AXI_bready[0] = m00_couplers_to_m00_couplers_BREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
  assign S_AXI_bvalid[0] = m00_couplers_to_m00_couplers_BVALID;
  assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready[0];
  assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid[0];
  assign M_AXI_rready[0] = m00_couplers_to_m00_couplers_RREADY;
  assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
  assign S_AXI_rvalid[0] = m00_couplers_to_m00_couplers_RVALID;
  assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready[0];
  assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid[0];
  assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID;
  assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY;
  assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
  assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready[0];
  assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0];
endmodule

