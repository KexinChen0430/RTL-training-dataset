
module s01_couplers_imp_1XMYHY6(M_ACLK,M_ARESETN,M_AXI_awaddr,M_AXI_awburst,M_AXI_awcache,
                                M_AXI_awlen,M_AXI_awprot,M_AXI_awready,M_AXI_awsize,
                                M_AXI_awvalid,M_AXI_bready,M_AXI_bresp,M_AXI_bvalid,
                                M_AXI_wdata,M_AXI_wlast,M_AXI_wready,M_AXI_wstrb,M_AXI_wvalid,
                                S_ACLK,S_ARESETN,S_AXI_awaddr,S_AXI_awburst,S_AXI_awcache,
                                S_AXI_awlen,S_AXI_awprot,S_AXI_awready,S_AXI_awsize,
                                S_AXI_awvalid,S_AXI_bready,S_AXI_bresp,S_AXI_bvalid,
                                S_AXI_wdata,S_AXI_wlast,S_AXI_wready,S_AXI_wstrb,S_AXI_wvalid);

  input  M_ACLK;
  input  M_ARESETN;
  output [31:0] M_AXI_awaddr;
  output [1:0] M_AXI_awburst;
  output [3:0] M_AXI_awcache;
  output [7:0] M_AXI_awlen;
  output [2:0] M_AXI_awprot;
  input  M_AXI_awready;
  output [2:0] M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input  [1:0] M_AXI_bresp;
  input  M_AXI_bvalid;
  output [63:0] M_AXI_wdata;
  output M_AXI_wlast;
  input  M_AXI_wready;
  output [7:0] M_AXI_wstrb;
  output M_AXI_wvalid;
  input  S_ACLK;
  input  S_ARESETN;
  input  [31:0] S_AXI_awaddr;
  input  [1:0] S_AXI_awburst;
  input  [3:0] S_AXI_awcache;
  input  [7:0] S_AXI_awlen;
  input  [2:0] S_AXI_awprot;
  output S_AXI_awready;
  input  [2:0] S_AXI_awsize;
  input  S_AXI_awvalid;
  input  S_AXI_bready;
  output [1:0] S_AXI_bresp;
  output S_AXI_bvalid;
  input  [63:0] S_AXI_wdata;
  input  S_AXI_wlast;
  output S_AXI_wready;
  input  [7:0] S_AXI_wstrb;
  input  S_AXI_wvalid;
  wire [31:0] s01_couplers_to_s01_couplers_AWADDR;
  wire [1:0] s01_couplers_to_s01_couplers_AWBURST;
  wire [3:0] s01_couplers_to_s01_couplers_AWCACHE;
  wire [7:0] s01_couplers_to_s01_couplers_AWLEN;
  wire [2:0] s01_couplers_to_s01_couplers_AWPROT;
  wire s01_couplers_to_s01_couplers_AWREADY;
  wire [2:0] s01_couplers_to_s01_couplers_AWSIZE;
  wire s01_couplers_to_s01_couplers_AWVALID;
  wire s01_couplers_to_s01_couplers_BREADY;
  wire [1:0] s01_couplers_to_s01_couplers_BRESP;
  wire s01_couplers_to_s01_couplers_BVALID;
  wire [63:0] s01_couplers_to_s01_couplers_WDATA;
  wire s01_couplers_to_s01_couplers_WLAST;
  wire s01_couplers_to_s01_couplers_WREADY;
  wire [7:0] s01_couplers_to_s01_couplers_WSTRB;
  wire s01_couplers_to_s01_couplers_WVALID;

  assign M_AXI_awaddr[31:0] = s01_couplers_to_s01_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s01_couplers_to_s01_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s01_couplers_to_s01_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = s01_couplers_to_s01_couplers_AWLEN;
  assign M_AXI_awprot[2:0] = s01_couplers_to_s01_couplers_AWPROT;
  assign M_AXI_awsize[2:0] = s01_couplers_to_s01_couplers_AWSIZE;
  assign M_AXI_awvalid[0] = s01_couplers_to_s01_couplers_AWVALID;
  assign M_AXI_bready[0] = s01_couplers_to_s01_couplers_BREADY;
  assign M_AXI_wdata[63:0] = s01_couplers_to_s01_couplers_WDATA;
  assign M_AXI_wlast[0] = s01_couplers_to_s01_couplers_WLAST;
  assign M_AXI_wstrb[7:0] = s01_couplers_to_s01_couplers_WSTRB;
  assign M_AXI_wvalid[0] = s01_couplers_to_s01_couplers_WVALID;
  assign S_AXI_awready[0] = s01_couplers_to_s01_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = s01_couplers_to_s01_couplers_BRESP;
  assign S_AXI_bvalid[0] = s01_couplers_to_s01_couplers_BVALID;
  assign S_AXI_wready[0] = s01_couplers_to_s01_couplers_WREADY;
  assign s01_couplers_to_s01_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign s01_couplers_to_s01_couplers_AWBURST = S_AXI_awburst[1:0];
  assign s01_couplers_to_s01_couplers_AWCACHE = S_AXI_awcache[3:0];
  assign s01_couplers_to_s01_couplers_AWLEN = S_AXI_awlen[7:0];
  assign s01_couplers_to_s01_couplers_AWPROT = S_AXI_awprot[2:0];
  assign s01_couplers_to_s01_couplers_AWREADY = M_AXI_awready[0];
  assign s01_couplers_to_s01_couplers_AWSIZE = S_AXI_awsize[2:0];
  assign s01_couplers_to_s01_couplers_AWVALID = S_AXI_awvalid[0];
  assign s01_couplers_to_s01_couplers_BREADY = S_AXI_bready[0];
  assign s01_couplers_to_s01_couplers_BRESP = M_AXI_bresp[1:0];
  assign s01_couplers_to_s01_couplers_BVALID = M_AXI_bvalid[0];
  assign s01_couplers_to_s01_couplers_WDATA = S_AXI_wdata[63:0];
  assign s01_couplers_to_s01_couplers_WLAST = S_AXI_wlast[0];
  assign s01_couplers_to_s01_couplers_WREADY = M_AXI_wready[0];
  assign s01_couplers_to_s01_couplers_WSTRB = S_AXI_wstrb[7:0];
  assign s01_couplers_to_s01_couplers_WVALID = S_AXI_wvalid[0];
endmodule

