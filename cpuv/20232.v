module m02_couplers_imp_1QFTZ3X
   (
    input M_ACLK,                 
    input [0:0]M_ARESETN,         
    output [10:0]M_AXI_araddr,    
    input M_AXI_arready,          
    output M_AXI_arvalid,         
    output [10:0]M_AXI_awaddr,    
    input M_AXI_awready,          
    output M_AXI_awvalid,         
    output M_AXI_bready,          
    input [1:0]M_AXI_bresp,       
    input M_AXI_bvalid,           
    input [31:0]M_AXI_rdata,      
    output M_AXI_rready,          
    input [1:0]M_AXI_rresp,       
    input M_AXI_rvalid,           
    output [31:0]M_AXI_wdata,     
    input M_AXI_wready,           
    output [3:0]M_AXI_wstrb,      
    output M_AXI_wvalid,          
    input S_ACLK,                 
    input [0:0]S_ARESETN,         
    input [10:0]S_AXI_araddr,     
    output S_AXI_arready,         
    input S_AXI_arvalid,          
    input [10:0]S_AXI_awaddr,     
    output S_AXI_awready,         
    input S_AXI_awvalid,          
    input S_AXI_bready,           
    output [1:0]S_AXI_bresp,      
    output S_AXI_bvalid,          
    output [31:0]S_AXI_rdata,     
    input S_AXI_rready,           
    output [1:0]S_AXI_rresp,      
    output S_AXI_rvalid,          
    input [31:0]S_AXI_wdata,      
    output S_AXI_wready,          
    input [3:0]S_AXI_wstrb,       
    input S_AXI_wvalid            
   );
wire [10:0]m02_couplers_to_m02_couplers_ARADDR;
wire m02_couplers_to_m02_couplers_ARREADY;
wire m02_couplers_to_m02_couplers_ARVALID;
wire [10:0]m02_couplers_to_m02_couplers_AWADDR;
wire m02_couplers_to_m02_couplers_AWREADY;
wire m02_couplers_to_m02_couplers_AWVALID;
wire m02_couplers_to_m02_couplers_BREADY;
wire [1:0]m02_couplers_to_m02_couplers_BRESP;
wire m02_couplers_to_m02_couplers_BVALID;
wire [31:0]m02_couplers_to_m02_couplers_RDATA;
wire m02_couplers_to_m02_couplers_RREADY;
wire [1:0]m02_couplers_to_m02_couplers_RRESP;
wire m02_couplers_to_m02_couplers_RVALID;
wire [31:0]m02_couplers_to_m02_couplers_WDATA;
wire m02_couplers_to_m02_couplers_WREADY;
wire [3:0]m02_couplers_to_m02_couplers_WSTRB;
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