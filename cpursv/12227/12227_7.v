
module saxi_test(output ERROR,
                 output DONE,
                 output s_axi_awready,
                 output s_axi_wready,
                 output [(-1)+MIDW:0] s_axi_bid,
                 output [1:0] s_axi_bresp,
                 output s_axi_bvalid,
                 output s_axi_arready,
                 output [(-1)+MIDW:0] s_axi_rid,
                 output [MDW-1:0] s_axi_rdata,
                 output [1:0] s_axi_rresp,
                 output s_axi_rlast,
                 output s_axi_rvalid,
                 input  s_axi_aclk,
                 input  s_axi_aresetn,
                 input  [(-1)+MIDW:0] s_axi_awid,
                 input  [MAW+(-1):0] s_axi_awaddr,
                 input  [3:0] s_axi_awlen,
                 input  [1+1:0] s_axi_awsize,
                 input  [1:0] s_axi_awburst,
                 input  [1:0] s_axi_awlock,
                 input  [3:0] s_axi_awcache,
                 input  [1+1:0] s_axi_awprot,
                 input  s_axi_awvalid,
                 input  [3:0] s_axi_awqos,
                 input  [(-1)+MIDW:0] s_axi_wid,
                 input  [MDW-1:0] s_axi_wdata,
                 input  [MSTW+(-1):0] s_axi_wstrb,
                 input  s_axi_wlast,
                 input  s_axi_wvalid,
                 input  s_axi_bready,
                 input  [(-1)+MIDW:0] s_axi_arid,
                 input  [MAW+(-1):0] s_axi_araddr,
                 input  [3:0] s_axi_arlen,
                 input  [1+1:0] s_axi_arsize,
                 input  [1:0] s_axi_arburst,
                 input  [1:0] s_axi_arlock,
                 input  [3:0] s_axi_arcache,
                 input  [1+1:0] s_axi_arprot,
                 input  s_axi_arvalid,
                 input  [3:0] s_axi_arqos,
                 input  s_axi_rready);

  parameter  MIDW = 6;
  parameter  MAW = 32;
  parameter  MDW = 64;
  parameter  MSTW = 8;
  output ERROR;
  output DONE;
  input  s_axi_aclk;
  input  s_axi_aresetn;
  input  [(-1)+MIDW:0] s_axi_awid;
  input  [MAW+(-1):0] s_axi_awaddr;
  input  [3:0] s_axi_awlen;
  input  [1+1:0] s_axi_awsize;
  input  [1:0] s_axi_awburst;
  input  [1:0] s_axi_awlock;
  input  [3:0] s_axi_awcache;
  input  [1+1:0] s_axi_awprot;
  input  s_axi_awvalid;
  input  [3:0] s_axi_awqos;
  output s_axi_awready;
  input  [(-1)+MIDW:0] s_axi_wid;
  input  [MDW-1:0] s_axi_wdata;
  input  [MSTW+(-1):0] s_axi_wstrb;
  input  s_axi_wlast;
  input  s_axi_wvalid;
  output s_axi_wready;
  input  s_axi_bready;
  output [(-1)+MIDW:0] s_axi_bid;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input  [(-1)+MIDW:0] s_axi_arid;
  input  [MAW+(-1):0] s_axi_araddr;
  input  [3:0] s_axi_arlen;
  input  [1+1:0] s_axi_arsize;
  input  [1:0] s_axi_arburst;
  input  [1:0] s_axi_arlock;
  input  [3:0] s_axi_arcache;
  input  [1+1:0] s_axi_arprot;
  input  s_axi_arvalid;
  input  [3:0] s_axi_arqos;
  output s_axi_arready;
  output [(-1)+MIDW:0] s_axi_rid;
  output [MDW-1:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input  s_axi_rready;

  
  initial  
  begin
    ERROR <= 1'b0;
    DONE <= 1'b0;
  end
  wire  s_axi_awready = 1'b1;

  wire  s_axi_wready = 1'b1;

  reg  [(-1)+MIDW:0] s_axi_bid;

  wire [1:0] s_axi_bresp;

  reg  s_axi_bvalid;

  
  always @(posedge s_axi_aclk or negedge s_axi_aresetn)
      begin
        if (~s_axi_aresetn) 
          begin
            s_axi_bid <= {MIDW{1'b0}};
            s_axi_bvalid <= 1'b0;
          end
        else 
          begin
            if (s_axi_wready && s_axi_wvalid) 
              begin
                s_axi_bid <= s_axi_wid;
                s_axi_bvalid <= 1'b1;
              end
            else if (s_axi_bready) 
              begin
                s_axi_bvalid <= 1'b0;
              end
              
          end
      end
  reg  s_axi_arready;

  
  always @(posedge s_axi_aclk or negedge s_axi_aresetn)
      begin
        if (~s_axi_aresetn) 
          begin
            s_axi_arready <= 1'b0;
          end
        else 
          begin

          end
      end
  reg  [(-1)+MIDW:0] s_axi_rid;

  reg  [MDW-1:0] s_axi_rdata;

  reg  [1:0] s_axi_rresp;

  wire  s_axi_rlast = 1'b1;

  reg  s_axi_rvalid;

endmodule

