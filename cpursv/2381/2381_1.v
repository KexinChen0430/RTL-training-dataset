
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(input  [5:0] s_axi_gcd_bus_AWADDR,
                                                 input  s_axi_gcd_bus_AWVALID,
                                                 output s_axi_gcd_bus_AWREADY,
                                                 input  [31:0] s_axi_gcd_bus_WDATA,
                                                 input  [3:0] s_axi_gcd_bus_WSTRB,
                                                 input  s_axi_gcd_bus_WVALID,
                                                 output s_axi_gcd_bus_WREADY,
                                                 output [1:0] s_axi_gcd_bus_BRESP,
                                                 output s_axi_gcd_bus_BVALID,
                                                 input  s_axi_gcd_bus_BREADY,
                                                 input  [5:0] s_axi_gcd_bus_ARADDR,
                                                 input  s_axi_gcd_bus_ARVALID,
                                                 output s_axi_gcd_bus_ARREADY,
                                                 output [31:0] s_axi_gcd_bus_RDATA,
                                                 output [1:0] s_axi_gcd_bus_RRESP,
                                                 output s_axi_gcd_bus_RVALID,
                                                 input  s_axi_gcd_bus_RREADY,
                                                 input  ap_clk,
                                                 input  ap_rst_n,
                                                 output interrupt);


endmodule

