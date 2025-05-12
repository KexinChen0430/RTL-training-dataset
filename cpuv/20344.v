module m00_couplers_imp_ZVW4AE
   (
    input M_ACLK,                 
    input [0:0]M_ARESETN,         
    output [8:0]M_AXI_araddr,     
    input [0:0]M_AXI_arready,     
    output [0:0]M_AXI_arvalid,    
    output [8:0]M_AXI_awaddr,     
    input [0:0]M_AXI_awready,     
    output [0:0]M_AXI_awvalid,    
    output [0:0]M_AXI_bready,     
    input [1:0]M_AXI_bresp,       
    input [0:0]M_AXI_bvalid,      
    input [31:0]M_AXI_rdata,      
    output [0:0]M_AXI_rready,     
    input [1:0]M_AXI_rresp,       
    input [0:0]M_AXI_rvalid,      
    output [31:0]M_AXI_wdata,     
    input [0:0]M_AXI_wready,      
    output [3:0]M_AXI_wstrb,      
    output [0:0]M_AXI_wvalid,     
    input S_ACLK,                 
    input [0:0]S_ARESETN,         
    input [8:0]S_AXI_araddr,      
    output [0:0]S_AXI_arready,    
    input [0:0]S_AXI_arvalid,     
    input [8:0]S_AXI_awaddr,      
    output [0:0]S_AXI_awready,    
    input [0:0]S_AXI_awvalid,     
    input [0:0]S_AXI_bready,      
    output [1:0]S_AXI_bresp,      
    output [0:0]S_AXI_bvalid,     
    output [31:0]S_AXI_rdata,     
    input [0:0]S_AXI_rready,      
    output [1:0]S_AXI_rresp,      
    output [0:0]S_AXI_rvalid,     
    input [31:0]S_AXI_wdata,      
    output [0:0]S_AXI_wready,     
    input [3:0]S_AXI_wstrb,       
    input [0:0]S_AXI_wvalid       
   );
wire [8:0]m00_couplers_to_m00_couplers_ARADDR;
wire [0:0]m00_couplers_to_m00_couplers_ARREADY;
wire [0:0]m00_couplers_to_m00_couplers_ARVALID;
wire [8:0]m00_couplers_to_m00_couplers_AWADDR;
wire [0:0]m00_couplers_to_m00_couplers_AWREADY;
wire [0:0]m00_couplers_to_m00_couplers_AWVALID;
wire [0:0]m00_couplers_to_m00_couplers_BREADY;
wire [1:0]m00_couplers_to_m00_couplers_BRESP;
wire [0:0]m00_couplers_to_m00_couplers_BVALID;
wire [31:0]m00_couplers_to_m00_couplers_RDATA;
wire [0:0]m00_couplers_to_m00_couplers_RREADY;
wire [1:0]m00_couplers_to_m00_couplers_RRESP;
wire [0:0]m00_couplers_to_m00_couplers_RVALID;
wire [31:0]m00_couplers_to_m00_couplers_WDATA;
wire [0:0]m00_couplers_to_m00_couplers_WREADY;
wire [3:0]m00_couplers_to_m00_couplers_WSTRB;
wire [0:0]m00_couplers_to_m00_couplers_WVALID;
assign M_AXI_araddr[8:0] = m00_couplers_to_m00_couplers_ARADDR;
assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID;
assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY;
assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[8:0];
assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0];
assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid[0];
assign M_AXI_awaddr[8:0] = m00_couplers_to_m00_couplers_AWADDR;
assign M_AXI_awvalid[0] = m00_couplers_to_m00_couplers_AWVALID;
assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY;
assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[8:0];
assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready[0];
assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid[0];
assign M_AXI_bready[0] = m00_couplers_to_m00_couplers_BREADY;
assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
assign S_AXI_bvalid[0] = m00_couplers_to_m00_couplers_BVALID;
assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready[0];
assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid[0];
assign M_AXI_rready[0] = m00_couplers_to_m00_couplers_RREADY;
assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
assign S_AXI_rvalid[0] = m00_couplers_to_m00_couplers_RVALID;
assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready[0];
assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid[0];
assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID;
assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY;
assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready[0];
assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0];
endmodule 