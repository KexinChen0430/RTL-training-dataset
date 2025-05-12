module m02_couplers_imp_MVV5YQ
   (M_ACLK,
    ...
    S_AXI_wready,
    S_AXI_wvalid);
input M_ACLK;
input [0:0]M_ARESETN;
output [8:0]M_AXI_araddr;
...
input S_AXI_wready;
input S_AXI_wvalid;
wire [8:0]m02_couplers_to_m02_couplers_ARADDR;
...
wire m02_couplers_to_m02_couplers_WVALID;
assign M_AXI_araddr[8:0] = m02_couplers_to_m02_couplers_ARADDR;
...
assign m02_couplers_to_m02_couplers_WVALID = S_AXI_wvalid;
endmodule