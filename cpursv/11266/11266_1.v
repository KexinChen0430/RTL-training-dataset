
module gcd_block_design_auto_pc_1(aclk,aresetn,s_axi_awid,s_axi_awaddr,s_axi_awlen,
                                  s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,
                                  s_axi_awprot,s_axi_awqos,s_axi_awvalid,s_axi_awready,
                                  s_axi_wid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,
                                  s_axi_wready,s_axi_bid,s_axi_bresp,s_axi_bvalid,s_axi_bready,
                                  s_axi_arid,s_axi_araddr,s_axi_arlen,s_axi_arsize,
                                  s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,
                                  s_axi_arqos,s_axi_arvalid,s_axi_arready,s_axi_rid,s_axi_rdata,
                                  s_axi_rresp,s_axi_rlast,s_axi_rvalid,s_axi_rready,
                                  m_axi_awaddr,m_axi_awprot,m_axi_awvalid,m_axi_awready,
                                  m_axi_wdata,m_axi_wstrb,m_axi_wvalid,m_axi_wready,m_axi_bresp,
                                  m_axi_bvalid,m_axi_bready,m_axi_araddr,m_axi_arprot,
                                  m_axi_arvalid,m_axi_arready,m_axi_rdata,m_axi_rresp,
                                  m_axi_rvalid,m_axi_rready);

  input  aclk;
  input  aresetn;
  input  [11:0] s_axi_awid;
  input  [31:0] s_axi_awaddr;
  input  [3:0] s_axi_awlen;
  input  [2:0] s_axi_awsize;
  input  [1:0] s_axi_awburst;
  input  [1:0] s_axi_awlock;
  input  [3:0] s_axi_awcache;
  input  [2:0] s_axi_awprot;
  input  [3:0] s_axi_awqos;
  input  s_axi_awvalid;
  output s_axi_awready;
  input  [11:0] s_axi_wid;
  input  [31:0] s_axi_wdata;
  input  [3:0] s_axi_wstrb;
  input  s_axi_wlast;
  input  s_axi_wvalid;
  output s_axi_wready;
  output [11:0] s_axi_bid;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input  s_axi_bready;
  input  [11:0] s_axi_arid;
  input  [31:0] s_axi_araddr;
  input  [3:0] s_axi_arlen;
  input  [2:0] s_axi_arsize;
  input  [1:0] s_axi_arburst;
  input  [1:0] s_axi_arlock;
  input  [3:0] s_axi_arcache;
  input  [2:0] s_axi_arprot;
  input  [3:0] s_axi_arqos;
  input  s_axi_arvalid;
  output s_axi_arready;
  output [11:0] s_axi_rid;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input  s_axi_rready;
  output [31:0] m_axi_awaddr;
  output [2:0] m_axi_awprot;
  output m_axi_awvalid;
  input  m_axi_awready;
  output [31:0] m_axi_wdata;
  output [3:0] m_axi_wstrb;
  output m_axi_wvalid;
  input  m_axi_wready;
  input  [1:0] m_axi_bresp;
  input  m_axi_bvalid;
  output m_axi_bready;
  output [31:0] m_axi_araddr;
  output [2:0] m_axi_arprot;
  output m_axi_arvalid;
  input  m_axi_arready;
  input  [31:0] m_axi_rdata;
  input  [1:0] m_axi_rresp;
  input  m_axi_rvalid;
  output m_axi_rready;


endmodule

