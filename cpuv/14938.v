module m02_couplers_imp_14WQB4R
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
output M_AXI_araddr;
input M_AXI_arready;
output M_AXI_arvalid;
output M_AXI_awaddr;
input M_AXI_awready;
output M_AXI_awvalid;
output M_AXI_bready;
input M_AXI_bresp;
input M_AXI_bvalid;
input M_AXI_rdata;
output M_AXI_rready;
input M_AXI_rresp;
input M_AXI_rvalid;
output M_AXI_wdata;
input M_AXI_wready;
output M_AXI_wstrb;
output M_AXI_wvalid;
input S_ACLK;
input S_ARESETN;
input S_AXI_araddr;
output S_AXI_arready;
input S_AXI_arvalid;
input S_AXI_awaddr;
output S_AXI_awready;
input S_AXI_awvalid;
input S_AXI_bready;
output S_AXI_bresp;
output S_AXI_bvalid;
output S_AXI_rdata;
input S_AXI_rready;
output S_AXI_rresp;
output S_AXI_rvalid;
input S_AXI_wdata;
output S_AXI_wready;
input S_AXI_wstrb;
input S_AXI_wvalid;
wire m02_couplers_to_m02_couplers_ARADDR;
wire m02_couplers_to_m02_couplers_ARREADY;
wire m02_couplers_to_m02_couplers_ARVALID;
wire m02_couplers_to_m02_couplers_AWADDR;
wire m02_couplers_to_m02_couplers_AWREADY;
wire m02_couplers_to_m02_couplers_AWVALID;
wire m02_couplers_to_m02_couplers_BREADY;
wire m02_couplers_to_m02_couplers_BRESP;
wire m02_couplers_to_m02_couplers_BVALID;
wire m02_couplers_to_m02_couplers_RDATA;
wire m02_couplers_to_m02_couplers_RREADY;
wire m02_couplers_to_m02_couplers_RRESP;
wire m02_couplers_to_m02_couplers_RVALID;
wire m02_couplers_to_m02_couplers_WDATA;
wire m02_couplers_to_m02_couplers_WREADY;
wire m02_couplers_to_m02_couplers_WSTRB;
wire m02_couplers_to_m02_couplers_WVALID;
assign M_AXI_araddr = m02_couplers_to_m02_couplers_ARADDR;
assign M_AXI_arvalid = m02_couplers_to_m02_couplers_ARVALID;
assign M_AXI_awaddr = m02_couplers_to_m02_couplers_AWADDR;
assign M_AXI_awvalid = m02_couplers_to_m02_couplers_AWVALID;
assign M_AXI_bready = m02_couplers_to_m02_couplers_BREADY;
assign M_AXI_rready = m02_couplers_to_m02_couplers_RREADY;
assign M_AXI_wdata = m02_couplers_to_m02_couplers_WDATA;
assign M_AXI_wstrb = m02_couplers_to_m02_couplers_WSTRB;
assign M_AXI_wvalid = m02_couplers_to_m02_couplers_WVALID;
assign S_AXI_arready = m02_couplers_to_m02_couplers_ARREADY;
assign S_AXI_awready = m02_couplers_to_m02_couplers_AWREADY;
assign S_AXI_bresp = m02_couplers_to_m02_couplers_BRESP;
assign S_AXI_bvalid = m02_couplers_to_m02_couplers_BVALID;
assign S_AXI_rdata = m02_couplers_to_m02_couplers_RDATA;
assign S_AXI_rresp = m02_couplers_to_m02_couplers_RRESP;
assign S_AXI_rvalid = m02_couplers_to_m02_couplers_RVALID;
assign S_AXI_wready = m02_couplers_to_m02_couplers_WREADY;
assign m02_couplers_to_m02_couplers_ARADDR = S_AXI_araddr;
assign m02_couplers_to_m02_couplers_ARREADY = M_AXI_arready;
assign m02_couplers_to_m02_couplers_ARVALID = S_AXI_arvalid;
assign m02_couplers_to_m02_couplers_AWADDR = S_AXI_awaddr;
assign m02_couplers_to_m02_couplers_AWREADY = M_AXI_awready;
assign m02_couplers_to_m02_couplers_AWVALID = S_AXI_awvalid;
assign m02_couplers_to_m02_couplers_BREADY = S_AXI_bready;
assign m02_couplers_to_m02_couplers_BRESP = M_AXI_bresp;
assign m02_couplers_to_m02_couplers_BVALID = M_AXI_bvalid;
assign m02_couplers_to_m02_couplers_RDATA = M_AXI_rdata;
assign m02_couplers_to_m02_couplers_RREADY = S_AXI_rready;
assign m02_couplers_to_m02_couplers_RRESP = M_AXI_rresp;
assign m02_couplers_to_m02_couplers_RVALID = M_AXI_rvalid;
assign m02_couplers_to_m02_couplers_WDATA = S_AXI_wdata;
assign m02_couplers_to_m02_couplers_WREADY = M_AXI_wready;
assign m02_couplers_to_m02_couplers_WSTRB = S_AXI_wstrb;
assign m02_couplers_to_m02_couplers_WVALID = S_AXI_wvalid;
endmodule