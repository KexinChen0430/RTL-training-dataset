module up_gt (
  output          up_drp_qpll0_sel,    
  output          up_drp_qpll0_wr,     
  output  [11:0]  up_drp_qpll0_addr,   
  output  [15:0]  up_drp_qpll0_wdata,  
  input   [15:0]  up_drp_qpll0_rdata,  
  input           up_drp_qpll0_ready,  
  output          up_drp_qpll1_sel,    
  output          up_drp_qpll1_wr,     
  output  [11:0]  up_drp_qpll1_addr,   
  output  [15:0]  up_drp_qpll1_wdata,  
  input   [15:0]  up_drp_qpll1_rdata,  
  input           up_drp_qpll1_ready,  
  input           up_rstn,             
  input           up_clk,              
  input           up_wreq,             
  input   [13:0]  up_waddr,            
  input   [31:0]  up_wdata,            
  output          up_wack,             
  input           up_rreq,             
  input   [13:0]  up_raddr,            
  output  [31:0]  up_rdata,            
  output          up_rack              
);
parameter   integer GTH_OR_GTX_N = 0;
reg             up_wack = 'd0;
reg             up_drp_qpll0_sel = 'd0;
reg             up_drp_qpll0_wr = 'd0;
reg             up_drp_qpll0_status = 'd0;
reg             up_drp_qpll0_rwn = 'd0;
reg     [11:0]  up_drp_qpll0_addr = 'd0;
reg     [15:0]  up_drp_qpll0_wdata = 'd0;
reg     [15:0]  up_drp_qpll0_rdata_hold = 'd0;
reg             up_drp_qpll1_sel = 'd0;
reg             up_drp_qpll1_wr = 'd0;
reg             up_drp_qpll1_status = 'd0;
reg             up_drp_qpll1_rwn = 'd0;
reg     [11:0]  up_drp_qpll1_addr = 'd0;
reg     [15:0]  up_drp_qpll1_wdata = 'd0;
reg     [15:0]  up_drp_qpll1_rdata_hold = 'd0;
reg             up_rack = 'd0;
reg     [31:0]  up_rdata = 'd0;
wire            up_wreq_s;
wire            up_rreq_s;
assign up_wreq_s = (up_waddr[13:8] == 6'h10) ? up_wreq : 1'b0;
assign up_rreq_s = (up_raddr[13:8] == 6'h10) ? up_rreq : 1'b0;
always @(negedge up_rstn or posedge up_clk) begin
  if (up_rstn == 0) begin
    up_wack <= 'd0;
    up_drp_qpll0_sel <= 'd0;
    up_drp_qpll0_wr <= 'd0;
    up_drp_qpll0_status <= 'd0;
    up_drp_qpll0_rwn <= 'd0;
    up_drp_qpll0_addr <= 'd0;
    up_drp_qpll0_wdata <= 'd0;
    up_drp_qpll0_rdata_hold <= 'd0;
    up_drp_qpll1_sel <= 'd0;
    up_drp_qpll1_wr <= 'd0;
    up_drp_qpll1_status <= 'd0;
    up_drp_qpll1_rwn <= 'd0;
    up_drp_qpll1_addr <= 'd0;
    up_drp_qpll1_wdata <= 'd0;
    up_drp_qpll1_rdata_hold <= 'd0;
  end else begin
    up_wack <= up_wreq_s; 
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h14)) begin
      up_drp_qpll0_sel <= 1'b1;
      up_drp_qpll0_wr <= ~up_wdata[28];
    end else begin
      up_drp_qpll0_sel <= 1'b0;
      up_drp_qpll0_wr <= 1'b0;
    end
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h14)) begin
      up_drp_qpll0_status <= 1'b1;
    end else if (up_drp_qpll0_ready == 1'b1) begin
      up_drp_qpll0_status <= 1'b0;
    end
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h14)) begin
      up_drp_qpll0_rwn <= up_wdata[28];
      up_drp_qpll0_addr <= up_wdata[27:16];
      up_drp_qpll0_wdata <= up_wdata[15:0];
    end
    if (up_drp_qpll0_ready == 1'b1) begin
      up_drp_qpll0_rdata_hold <= up_drp_qpll0_rdata;
    end
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h24)) begin
      up_drp_qpll1_sel <= 1'b1;
      up_drp_qpll1_wr <= ~up_wdata[28];
    end else begin
      up_drp_qpll1_sel <= 1'b0;
      up_drp_qpll1_wr <= 1'b0;
    end
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h24)) begin
      up_drp_qpll1_status <= 1'b1;
    end else if (up_drp_qpll1_ready == 1'b1) begin
      up_drp_qpll1_status <= 1'b0;
    end
    if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h24)) begin
      up_drp_qpll1_rwn <= up_wdata[28];
      up_drp_qpll1_addr <= up_wdata[27:16];
      up_drp_qpll1_wdata <= up_wdata[15:0];
    end
    if (up_drp_qpll1_ready == 1'b1) begin
      up_drp_qpll1_rdata_hold <= up_drp_qpll1_rdata;
    end
  end
end
always @(negedge up_rstn or posedge up_clk) begin
  if (up_rstn == 0) begin
    up_rack <= 'd0;
    up_rdata <= 'd0;
  end else begin
    up_rack <= up_rreq_s; 
    if (up_rreq_s == 1'b1) begin
      case (up_raddr[7:0])
        8'h14: up_rdata <= {3'd0, up_drp_qpll0_rwn, up_drp_qpll0_addr, up_drp_qpll0_wdata};
        8'h15: up_rdata <= {15'd0, up_drp_qpll0_status, up_drp_qpll0_rdata_hold};
        8'h24: up_rdata <= {3'd0, up_drp_qpll1_rwn, up_drp_qpll1_addr, up_drp_qpll1_wdata};
        8'h25: up_rdata <= {15'd0, up_drp_qpll1_status, up_drp_qpll1_rdata_hold};
        8'h3a: up_rdata <= GTH_OR_GTX_N; 
        default: up_rdata <= 0; 
      endcase
    end else begin
      up_rdata <= 32'd0; 
    end
  end
end
endmodule