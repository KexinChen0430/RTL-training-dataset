
module dma_engine_rr_arb(input  [3:0] dma_wr_mac,
                         input  [15:0] dma_pkt_avail,
                         input  dma_rd_request,
                         output reg [3:0] dma_rd_request_q,
                         output [15:0] dma_wr_mac_one_hot,
                         output reg dma_rd_request_q_vld,
                         input  ctrl_done,
                         input  dma_in_progress,
                         input  xfer_is_rd,
                         input  cnet_reprog,
                         input  reset,
                         input  clk);

  reg  [3:0] pref_to_read;
  reg  [3:0] mac_search;
  wire [15:0] mac_search_one_hot;

  
  always @(posedge clk)
      begin
        if (reset || cnet_reprog) pref_to_read <= 4'h0;
        else if (xfer_is_rd && ctrl_done) pref_to_read <= 'h1+pref_to_read;
        else if (dma_rd_request) pref_to_read <= dma_rd_request_q;
          
      end
  
  always @(posedge clk)
      begin
        if (reset || cnet_reprog) 
          begin
            dma_rd_request_q <= 4'hf;
            mac_search <= 4'hf;
            dma_rd_request_q_vld <= 1'b0;
          end
        else if (xfer_is_rd && dma_rd_request) 
          begin
            dma_rd_request_q_vld <= 1'b0;
          end
        else if (xfer_is_rd && ctrl_done) 
          begin
            dma_rd_request_q <= pref_to_read;
            mac_search <= pref_to_read;
            dma_rd_request_q_vld <= 1'b0;
          end
        else 
          begin
            if (dma_rd_request_q != pref_to_read) 
              begin
                if (mac_search == pref_to_read) mac_search <= dma_rd_request_q;
                else mac_search <= mac_search-'h1;
                if (dma_pkt_avail & mac_search_one_hot) 
                  begin
                    dma_rd_request_q <= mac_search;
                    dma_rd_request_q_vld <= 1'b1;
                  end
                  
              end
              
          end
      end
  assign dma_wr_mac_one_hot = {dma_wr_mac == 4'hf,dma_wr_mac == 4'he,dma_wr_mac == 4'hd,dma_wr_mac == 4'hc,dma_wr_mac == 4'hb,dma_wr_mac == 4'ha,dma_wr_mac == 4'h9,dma_wr_mac == 4'h8,dma_wr_mac == 4'h7,dma_wr_mac == 4'h6,dma_wr_mac == 4'h5,dma_wr_mac == 4'h4,dma_wr_mac == 4'h3,dma_wr_mac == 4'h2,dma_wr_mac == 4'h1,dma_wr_mac == 4'h0};
  assign mac_search_one_hot = {mac_search == 4'hf,mac_search == 4'he,mac_search == 4'hd,mac_search == 4'hc,mac_search == 4'hb,mac_search == 4'ha,mac_search == 4'h9,mac_search == 4'h8,mac_search == 4'h7,mac_search == 4'h6,mac_search == 4'h5,mac_search == 4'h4,mac_search == 4'h3,mac_search == 4'h2,mac_search == 4'h1,mac_search == 4'h0};
endmodule

