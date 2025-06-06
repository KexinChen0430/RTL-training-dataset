
module axi_bram_ctrl_16b(s_axi_aclk,s_axi_aresetn,s_axi_awaddr,s_axi_awprot,
                         s_axi_awvalid,s_axi_awready,s_axi_wdata,s_axi_wstrb,
                         s_axi_wvalid,s_axi_wready,s_axi_bresp,s_axi_bvalid,
                         s_axi_bready,s_axi_araddr,s_axi_arprot,s_axi_arvalid,
                         s_axi_arready,s_axi_rdata,s_axi_rresp,s_axi_rvalid,
                         s_axi_rready,bram_rst_a,bram_clk_a,bram_en_a,bram_we_a,
                         bram_addr_a,bram_wrdata_a,bram_rddata_a);

  input  s_axi_aclk;
  input  s_axi_aresetn;
  input  [15:0] s_axi_awaddr;
  input  [2:0] s_axi_awprot;
  input  s_axi_awvalid;
  output s_axi_awready;
  input  [31:0] s_axi_wdata;
  input  [3:0] s_axi_wstrb;
  input  s_axi_wvalid;
  output s_axi_wready;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input  s_axi_bready;
  input  [15:0] s_axi_araddr;
  input  [2:0] s_axi_arprot;
  input  s_axi_arvalid;
  output s_axi_arready;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rvalid;
  input  s_axi_rready;
  output bram_rst_a;
  output bram_clk_a;
  output bram_en_a;
  output [3:0] bram_we_a;
  output [15:0] bram_addr_a;
  output [31:0] bram_wrdata_a;
  input  [31:0] bram_rddata_a;


endmodule

