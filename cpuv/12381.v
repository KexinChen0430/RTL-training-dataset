module m03_couplers_imp_1OV3LN4
   (M_ACLK, 
    M_ARESETN, 
    M_AXI_araddr, 
    M_AXI_arready, 
    M_AXI_arvalid, 
    M_AXI_awaddr, 
    M_AXI_awready, 
    M_AXI_awvalid, 
    M_AXI_bready, 
    M_AXI_bresp, 
    M_AXI_bvalid, 
    M_AXI_rdata, 
    M_AXI_rready, 
    M_AXI_rresp, 
    M_AXI_rvalid, 
    M_AXI_wdata, 
    M_AXI_wready, 
    M_AXI_wstrb, 
    M_AXI_wvalid, 
    S_ACLK, 
    S_ARESETN, 
    S_AXI_araddr, 
    S_AXI_arready, 
    S_AXI_arvalid, 
    S_AXI_awaddr, 
    S_AXI_awready, 
    S_AXI_awvalid, 
    S_AXI_bready, 
    S_AXI_bresp, 
    S_AXI_bvalid, 
    S_AXI_rdata, 
    S_AXI_rready, 
    S_AXI_rresp, 
    S_AXI_rvalid, 
    S_AXI_wdata, 
    S_AXI_wready, 
    S_AXI_wstrb, 
    S_AXI_wvalid); 
input M_ACLK;
input M_ARESETN;
output [31:0]M_AXI_araddr;
input M_AXI_arready;
output M_AXI_arvalid;
output [31:0]M_AXI_awaddr;
input M_AXI_awready;
output M_AXI_awvalid;
output M_AXI_bready;
input [1:0]M_AXI_bresp;
input M_AXI_bvalid;
input [31:0]M_AXI_rdata;
output M_AXI_rready;
input [1:0]M_AXI_rresp;
input M_AXI_rvalid;
output [31:0]M_AXI_wdata;
input M_AXI_wready;
output [3:0]M_AXI_wstrb;
output M_AXI_wvalid;
input S_ACLK;
input S_ARESETN;
input [31:0]S_AXI_araddr;
output S_AXI_arready;
input S_AXI_arvalid;
input [31:0]S_AXI_awaddr;
output S_AXI_awready;
input S_AXI_awvalid;
input S_AXI_bready;
output [1:0]S_AXI_bresp;
output S_AXI_bvalid;
output [31:0]S_AXI_rdata;
input S_AXI_rready;
output [1:0]S_AXI_rresp;
output S_AXI_rvalid;
input [31:0]S_AXI_wdata;
output S_AXI_wready;
input [3:0]S_AXI_wstrb;
input S_AXI_wvalid;
wire [31:0]m03_couplers_to_m03_couplers_ARADDR;
wire m03_couplers_to_m03_couplers_ARREADY;
wire m03_couplers_to_m03_couplers_ARVALID;
wire [31:0]m03_couplers_to_m03_couplers_AWADDR;
wire m03_couplers_to_m03_couplers_AWREADY;
wire m03_couplers_to_m03_couplers_AWVALID;
wire m03_couplers_to_m03_couplers_BREADY;
wire [1:0]m03_couplers_to_m03_couplers_BRESP;
wire m03_couplers_to_m03_couplers_BVALID;
wire [31:0]m03_couplers_to_m03_couplers_RDATA;
wire m03_couplers_to_m03_couplers_RREADY;
wire [1:0]m03_couplers_to_m03_couplers_RRESP;
wire m03_couplers_to_m03_couplers_RVALID;
wire [31:0]m03_couplers_to_m03_couplers_WDATA;
wire m03_couplers_to_m03_couplers_WREADY;
wire [3:0]m03_couplers_to_m03_couplers_WSTRB;
wire m03_couplers_to_m03_couplers_WVALID;
assign M_AXI_araddr[31:0] = m03_couplers_to_m03_couplers_ARADDR;
assign M_AXI_arvalid = m03_couplers_to_m03_couplers_ARVALID;
assign M_AXI_awaddr[31:0] = m03_couplers_to_m03_couplers_AWADDR;
assign M_AXI_awvalid = m03_couplers_to_m03_couplers_AWVALID;
assign M_AXI_bready = m03_couplers_to_m03_couplers_BREADY;
assign M_AXI_rready = m03_couplers_to_m03_couplers_RREADY;
assign M_AXI_wdata[31:0] = m03_couplers_to_m03_couplers_WDATA;
assign M_AXI_wstrb[3:0] = m03_couplers_to_m03_couplers_WSTRB;
assign M_AXI_wvalid = m03_couplers_to_m03_couplers_WVALID;
assign S_AXI_arready = m03_couplers_to_m03_couplers_ARREADY;
assign S_AXI_awready = m03_couplers_to_m03_couplers_AWREADY;
assign S_AXI_bresp[1:0] = m03_couplers_to_m03_couplers_BRESP;
assign S_AXI_bvalid = m03_couplers_to_m03_couplers_BVALID;
assign S_AXI_rdata[31:0] = m03_couplers_to_m03_couplers_RDATA;
assign S_AXI_rresp[1:0] = m03_couplers_to_m03_couplers_RRESP;
assign S_AXI_rvalid = m03_couplers_to_m03_couplers_RVALID;
assign S_AXI_wready = m03_couplers_to_m03_couplers_WREADY;
assign m03_couplers_to_m03_couplers_ARADDR = S_AXI_araddr[31:0];
assign m03_couplers_to_m03_couplers_ARREADY = M_AXI_arready;
assign m03_couplers_to_m03_couplers_ARVALID = S_AXI_arvalid;
assign m03_couplers_to_m03_couplers_AWADDR = S_AXI_awaddr[31:0];
assign m03_couplers_to_m03_couplers_AWREADY = M_AXI_awready;
assign m03_couplers_to_m03_couplers_AWVALID = S_AXI_awvalid;
assign m03_couplers_to_m03_couplers_BREADY = S_AXI_bready;
assign m03_couplers_to_m03_couplers_BRESP = M_AXI_bresp[1:0];
assign m03_couplers_to_m03_couplers_BVALID = M_AXI_bvalid;
assign m03_couplers_to_m03_couplers_RDATA = M_AXI_rdata[31:0];
assign m03_couplers_to_m03_couplers_RREADY = S_AXI_rready;
assign m03_couplers_to_m03_couplers_RRESP = M_AXI_rresp[1:0];
assign m03_couplers_to_m03_couplers_RVALID = M_AXI_rvalid;
assign m03_couplers_to_m03_couplers_WDATA = S_AXI_wdata[31:0];
assign m03_couplers_to_m03_couplers_WREADY = M_AXI_wready;
assign m03_couplers_to_m03_couplers_WSTRB = S_AXI_wstrb[3:0];
assign m03_couplers_to_m03_couplers_WVALID = S_AXI_wvalid;
endmodule