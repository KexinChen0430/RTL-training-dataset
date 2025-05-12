
module DemoInterconnect_mutex_0_0(input  S0_AXI_ACLK,
                                  input  S0_AXI_ARESETN,
                                  input  [31:0] S0_AXI_AWADDR,
                                  input  S0_AXI_AWVALID,
                                  output S0_AXI_AWREADY,
                                  input  [31:0] S0_AXI_WDATA,
                                  input  [3:0] S0_AXI_WSTRB,
                                  input  S0_AXI_WVALID,
                                  output S0_AXI_WREADY,
                                  output [1:0] S0_AXI_BRESP,
                                  output S0_AXI_BVALID,
                                  input  S0_AXI_BREADY,
                                  input  [31:0] S0_AXI_ARADDR,
                                  input  S0_AXI_ARVALID,
                                  output S0_AXI_ARREADY,
                                  output [31:0] S0_AXI_RDATA,
                                  output [1:0] S0_AXI_RRESP,
                                  output S0_AXI_RVALID,
                                  input  S0_AXI_RREADY,
                                  input  S1_AXI_ACLK,
                                  input  S1_AXI_ARESETN,
                                  input  [31:0] S1_AXI_AWADDR,
                                  input  S1_AXI_AWVALID,
                                  output S1_AXI_AWREADY,
                                  input  [31:0] S1_AXI_WDATA,
                                  input  [3:0] S1_AXI_WSTRB,
                                  input  S1_AXI_WVALID,
                                  output S1_AXI_WREADY,
                                  output [1:0] S1_AXI_BRESP,
                                  output S1_AXI_BVALID,
                                  input  S1_AXI_BREADY,
                                  input  [31:0] S1_AXI_ARADDR,
                                  input  S1_AXI_ARVALID,
                                  output S1_AXI_ARREADY,
                                  output [31:0] S1_AXI_RDATA,
                                  output [1:0] S1_AXI_RRESP,
                                  output S1_AXI_RVALID,
                                  input  S1_AXI_RREADY,
                                  input  S2_AXI_ACLK,
                                  input  S2_AXI_ARESETN,
                                  input  [31:0] S2_AXI_AWADDR,
                                  input  S2_AXI_AWVALID,
                                  output S2_AXI_AWREADY,
                                  input  [31:0] S2_AXI_WDATA,
                                  input  [3:0] S2_AXI_WSTRB,
                                  input  S2_AXI_WVALID,
                                  output S2_AXI_WREADY,
                                  output [1:0] S2_AXI_BRESP,
                                  output S2_AXI_BVALID,
                                  input  S2_AXI_BREADY,
                                  input  [31:0] S2_AXI_ARADDR,
                                  input  S2_AXI_ARVALID,
                                  output S2_AXI_ARREADY,
                                  output [31:0] S2_AXI_RDATA,
                                  output [1:0] S2_AXI_RRESP,
                                  output S2_AXI_RVALID,
                                  input  S2_AXI_RREADY);

   ;
  input  S0_AXI_ACLK;

  input  S0_AXI_ARESETN;

  input  [31:0] S0_AXI_AWADDR;

  input  S0_AXI_AWVALID;

  output S0_AXI_AWREADY;

  input  [31:0] S0_AXI_WDATA;

  input  [3:0] S0_AXI_WSTRB;

  input  S0_AXI_WVALID;

  output S0_AXI_WREADY;

  output [1:0] S0_AXI_BRESP;

  output S0_AXI_BVALID;

  input  S0_AXI_BREADY;

  input  [31:0] S0_AXI_ARADDR;

  input  S0_AXI_ARVALID;

  output S0_AXI_ARREADY;

  output [31:0] S0_AXI_RDATA;

  output [1:0] S0_AXI_RRESP;

  output S0_AXI_RVALID;

  input  S0_AXI_RREADY;

  input  S1_AXI_ACLK;

  input  S1_AXI_ARESETN;

  input  [31:0] S1_AXI_AWADDR;

  input  S1_AXI_AWVALID;

  output S1_AXI_AWREADY;

  input  [31:0] S1_AXI_WDATA;

  input  [3:0] S1_AXI_WSTRB;

  input  S1_AXI_WVALID;

  output S1_AXI_WREADY;

  output [1:0] S1_AXI_BRESP;

  output S1_AXI_BVALID;

  input  S1_AXI_BREADY;

  input  [31:0] S1_AXI_ARADDR;

  input  S1_AXI_ARVALID;

  output S1_AXI_ARREADY;

  output [31:0] S1_AXI_RDATA;

  output [1:0] S1_AXI_RRESP;

  output S1_AXI_RVALID;

  input  S1_AXI_RREADY;

  input  S2_AXI_ACLK;

  input  S2_AXI_ARESETN;

  input  [31:0] S2_AXI_AWADDR;

  input  S2_AXI_AWVALID;

  output S2_AXI_AWREADY;

  input  [31:0] S2_AXI_WDATA;

  input  [3:0] S2_AXI_WSTRB;

  input  S2_AXI_WVALID;

  output S2_AXI_WREADY;

  output [1:0] S2_AXI_BRESP;

  output S2_AXI_BVALID;

  input  S2_AXI_BREADY;

  input  [31:0] S2_AXI_ARADDR;

  input  S2_AXI_ARVALID;

  output S2_AXI_ARREADY;

  output [31:0] S2_AXI_RDATA;

  output [1:0] S2_AXI_RRESP;

  output S2_AXI_RVALID;

  input  S2_AXI_RREADY;

endmodule

