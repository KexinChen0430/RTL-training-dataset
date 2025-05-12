module s00_couplers_imp_5VZGPS
   (M_ACLK, 
    M_ARESETN, 
    M_AXI_araddr, 
    M_AXI_arburst, 
    M_AXI_arcache, 
    M_AXI_arlen, 
    M_AXI_arprot, 
    M_AXI_arready, 
    M_AXI_arsize, 
    M_AXI_arvalid, 
    M_AXI_rdata, 
    M_AXI_rlast, 
    M_AXI_rready, 
    M_AXI_rresp, 
    M_AXI_rvalid, 
    S_ACLK, 
    S_ARESETN, 
    S_AXI_araddr, 
    S_AXI_arburst, 
    S_AXI_arcache, 
    S_AXI_arlen, 
    S_AXI_arprot, 
    S_AXI_arready, 
    S_AXI_arsize, 
    S_AXI_arvalid, 
    S_AXI_rdata, 
    S_AXI_rlast, 
    S_AXI_rready, 
    S_AXI_rresp, 
    S_AXI_rvalid); 
  input M_ACLK; 
  input [0:0]M_ARESETN; 
  output [31:0]M_AXI_araddr; 
  output [1:0]M_AXI_arburst; 
  output [3:0]M_AXI_arcache; 
  output [7:0]M_AXI_arlen; 
  output [2:0]M_AXI_arprot; 
  input [0:0]M_AXI_arready; 
  output [2:0]M_AXI_arsize; 
  output [0:0]M_AXI_arvalid; 
  input [63:0]M_AXI_rdata; 
  input [0:0]M_AXI_rlast; 
  output [0:0]M_AXI_rready; 
  input [1:0]M_AXI_rresp; 
  input [0:0]M_AXI_rvalid; 
  input S_ACLK; 
  input [0:0]S_ARESETN; 
  input [31:0]S_AXI_araddr; 
  input [1:0]S_AXI_arburst; 
  input [3:0]S_AXI_arcache; 
  input [7:0]S_AXI_arlen; 
  input [2:0]S_AXI_arprot; 
  output [0:0]S_AXI_arready; 
  input [2:0]S_AXI_arsize; 
  input [0:0]S_AXI_arvalid; 
  output [63:0]S_AXI_rdata; 
  output [0:0]S_AXI_rlast; 
  input [0:0]S_AXI_rready; 
  output [1:0]S_AXI_rresp; 
  output [0:0]S_AXI_rvalid; 
  wire [31:0]s00_couplers_to_s00_couplers_ARADDR; 
  wire [1:0]s00_couplers_to_s00_couplers_ARBURST; 
  wire [3:0]s00_couplers_to_s00_couplers_ARCACHE; 
  wire [7:0]s00_couplers_to_s00_couplers_ARLEN; 
  wire [2:0]s00_couplers_to_s00_couplers_ARPROT; 
  wire [0:0]s00_couplers_to_s00_couplers_ARREADY; 
  wire [2:0]s00_couplers_to_s00_couplers_ARSIZE; 
  wire [0:0]s00_couplers_to_s00_couplers_ARVALID; 
  wire [63:0]s00_couplers_to_s00_couplers_RDATA; 
  wire [0:0]s00_couplers_to_s00_couplers_RLAST; 
  wire [0:0]s00_couplers_to_s00_couplers_RREADY; 
  wire [1:0]s00_couplers_to_s00_couplers_RRESP; 
  wire [0:0]s00_couplers_to_s00_couplers_RVALID; 
  assign M_AXI_araddr[31:0] = s00_couplers_to_s00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s00_couplers_to_s00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s00_couplers_to_s00_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = s00_couplers_to_s00_couplers_ARLEN;
  assign M_AXI_arprot[2:0] = s00_couplers_to_s00_couplers_ARPROT;
  assign M_AXI_arsize[2:0] = s00_couplers_to_s00_couplers_ARSIZE;
  assign M_AXI_arvalid[0] = s00_couplers_to_s00_couplers_ARVALID;
  assign M_AXI_rready[0] = s00_couplers_to_s00_couplers_RREADY;
  assign S_AXI_arready[0] = s00_couplers_to_s00_couplers_ARREADY;
  assign S_AXI_rdata[63:0] = s00_couplers_to_s00_couplers_RDATA;
  assign S_AXI_rlast[0] = s00_couplers_to_s00_couplers_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_s00_couplers_RRESP;
  assign S_AXI_rvalid[0] = s00_couplers_to_s00_couplers_RVALID;
  assign s00_couplers_to_s00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_s00_couplers_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_s00_couplers_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_s00_couplers_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_s00_couplers_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_s00_couplers_ARREADY = M_AXI_arready[0];
  assign s00_couplers_to_s00_couplers_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_s00_couplers_ARVALID = S_AXI_arvalid[0];
  assign s00_couplers_to_s00_couplers_RDATA = M_AXI_rdata[63:0];
  assign s00_couplers_to_s00_couplers_RLAST = M_AXI_rlast[0];
  assign s00_couplers_to_s00_couplers_RREADY = S_AXI_rready[0];
  assign s00_couplers_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_couplers_to_s00_couplers_RVALID = M_AXI_rvalid[0];
endmodule