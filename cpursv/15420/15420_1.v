
module DemoInterconnect_axi_spi_master_0_0(output m_spi_mosi,
                                           input  m_spi_miso,
                                           output m_spi_ss,
                                           output m_spi_sclk,
                                           input  [3:0] s00_axi_awaddr,
                                           input  [2:0] s00_axi_awprot,
                                           input  s00_axi_awvalid,
                                           output s00_axi_awready,
                                           input  [31:0] s00_axi_wdata,
                                           input  [3:0] s00_axi_wstrb,
                                           input  s00_axi_wvalid,
                                           output s00_axi_wready,
                                           output [1:0] s00_axi_bresp,
                                           output s00_axi_bvalid,
                                           input  s00_axi_bready,
                                           input  [3:0] s00_axi_araddr,
                                           input  [2:0] s00_axi_arprot,
                                           input  s00_axi_arvalid,
                                           output s00_axi_arready,
                                           output [31:0] s00_axi_rdata,
                                           output [1:0] s00_axi_rresp,
                                           output s00_axi_rvalid,
                                           input  s00_axi_rready,
                                           input  s00_axi_aclk,
                                           input  s00_axi_aresetn);

   ;
endmodule

