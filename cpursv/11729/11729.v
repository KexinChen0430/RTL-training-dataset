
module ip_design_zed_audio_ctrl_0_0(BCLK,LRCLK,SDATA_I,SDATA_O,S_AXI_ACLK,S_AXI_ARESETN,
                                    S_AXI_AWADDR,S_AXI_AWVALID,S_AXI_WDATA,S_AXI_WSTRB,
                                    S_AXI_WVALID,S_AXI_BREADY,S_AXI_ARADDR,S_AXI_ARVALID,
                                    S_AXI_RREADY,S_AXI_ARREADY,S_AXI_RDATA,S_AXI_RRESP,
                                    S_AXI_RVALID,S_AXI_WREADY,S_AXI_BRESP,S_AXI_BVALID,
                                    S_AXI_AWREADY);

  output BCLK;
  output LRCLK;
  input  SDATA_I;
  output SDATA_O;
  input  S_AXI_ACLK;
  input  S_AXI_ARESETN;
  input  [31:0] S_AXI_AWADDR;
  input  S_AXI_AWVALID;
  input  [31:0] S_AXI_WDATA;
  input  [3:0] S_AXI_WSTRB;
  input  S_AXI_WVALID;
  input  S_AXI_BREADY;
  input  [31:0] S_AXI_ARADDR;
  input  S_AXI_ARVALID;
  input  S_AXI_RREADY;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  output S_AXI_AWREADY;


endmodule

