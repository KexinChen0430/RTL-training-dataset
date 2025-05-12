
module system_axi_gpio_1_0(input  s_axi_aclk,
                           input  s_axi_aresetn,
                           input  [8:0] s_axi_awaddr,
                           input  s_axi_awvalid,
                           output s_axi_awready,
                           input  [31:0] s_axi_wdata,
                           input  [3:0] s_axi_wstrb,
                           input  s_axi_wvalid,
                           output s_axi_wready,
                           output [1:0] s_axi_bresp,
                           output s_axi_bvalid,
                           input  s_axi_bready,
                           input  [8:0] s_axi_araddr,
                           input  s_axi_arvalid,
                           output s_axi_arready,
                           output [31:0] s_axi_rdata,
                           output [1:0] s_axi_rresp,
                           output s_axi_rvalid,
                           input  s_axi_rready,
                           output ip2intc_irpt,
                           input  [15:0] gpio_io_i,
                           output [15:0] gpio_io_o,
                           output [15:0] gpio_io_t);


endmodule

