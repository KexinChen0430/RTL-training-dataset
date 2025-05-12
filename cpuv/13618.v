module m00_couplers_imp_OBU1DD
   (M_ACLK, 
    M_ARESETN, 
    S_AXI_wready, 
    S_AXI_wvalid); 
  input M_ACLK; 
  input [0:0]M_ARESETN; 
  input [0:0]S_AXI_wvalid; 
  wire [31:0]m00_couplers_to_m00_couplers_ARADDR; 
  wire [0:0]m00_couplers_to_m00_couplers_ARREADY; 
  wire [0:0]m00_couplers_to_m00_couplers_WVALID; 
  assign M_AXI_araddr[31:0] = m00_couplers_to_m00_couplers_ARADDR; 
  assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID; 
  assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID; 
  assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY; 
  assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY; 
  assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY; 
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[31:0]; 
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0]; 
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0]; 
endmodule