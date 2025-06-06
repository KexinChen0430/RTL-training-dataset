
module system_axi_timer_0_0(capturetrig0,capturetrig1,generateout0,generateout1,pwm0,
                            interrupt,freeze,s_axi_aclk,s_axi_aresetn,s_axi_awaddr,
                            s_axi_awvalid,s_axi_awready,s_axi_wdata,s_axi_wstrb,
                            s_axi_wvalid,s_axi_wready,s_axi_bresp,s_axi_bvalid,
                            s_axi_bready,s_axi_araddr,s_axi_arvalid,s_axi_arready,
                            s_axi_rdata,s_axi_rresp,s_axi_rvalid,s_axi_rready);

   ;
  input  capturetrig0;

  input  capturetrig1;

  output generateout0;

  output generateout1;

  output pwm0;

  output interrupt;

  input  freeze;

  input  s_axi_aclk;

  input  s_axi_aresetn;

  input  [4:0] s_axi_awaddr;

  input  s_axi_awvalid;

  output s_axi_awready;

  input  [31:0] s_axi_wdata;

  input  [3:0] s_axi_wstrb;

  input  s_axi_wvalid;

  output s_axi_wready;

  output [1:0] s_axi_bresp;

  output s_axi_bvalid;

  input  s_axi_bready;

  input  [4:0] s_axi_araddr;

  input  s_axi_arvalid;

  output s_axi_arready;

  output [31:0] s_axi_rdata;

  output [1:0] s_axi_rresp;

  output s_axi_rvalid;

  input  s_axi_rready;

endmodule

