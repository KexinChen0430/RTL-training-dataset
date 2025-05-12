
module fifo_addr_oserdese1_vlog(qwc,qrd,rd_gap1,rst_bufg_wc,rst_bufo_rc,bufg_clk,bufo_clk,
                                data,extra,rst_bufop_rc,bufop_clk);

  input  bufg_clk,bufo_clk;
  input  rst_bufo_rc,rst_bufg_wc;
  input  rst_bufop_rc;
  input  data;
  input  bufop_clk;
  output qwc,qrd;
  output rd_gap1,extra;
  reg  [1:0] qwc;
  reg  [1:0] qrd;
  reg  stop_rd,rd_gap1,extra;
  reg  rd_cor,rd_cor_cnt,rd_cor_cnt1;
  wire qwc0_latch,qwc1_latch;
  wire li01,li02,li03;
  wire li11,li12,li13;
  wire qwc0_latchn,qwc1_latchn;
  wire li01n,li02n,li03n;
  wire li11n,li12n,li13n;
  reg  stop_rdn,rd_cor_cntn,rd_cor_cnt1n,stop_rc;
  reg  [1:0] qwcd;
  reg  [1:0] qrdd;
  reg  stop_rdd,rd_gap1d,extrad;
  reg  rd_cord,rd_cor_cntd,rd_cor_cnt1d;
  wire qwcd0_latch,qwcd1_latch;
  wire li01d,li02d,li03d;
  wire li11d,li12d,li13d;

  
  always @(posedge bufg_clk or posedge rst_bufg_wc)
      begin
        if (rst_bufg_wc) 
          begin
            qwc <= #10 2'b11;
          end
        else if ((((qwc[1] & (~qwc[0] | qwc[0])) & ~qwc[1]) | (qwc[0] & ~qwc[1])) | (~qwc[0] & qwc[1])) 
          begin
            qwc[1] <= #10 ~qwc[1];
            qwc[0] <= #10 qwc[0];
          end
        else 
          begin
            qwc[1] <= #10 qwc[1];
            qwc[0] <= #10 ~qwc[0];
          end
      end
  
  always @(posedge bufo_clk or posedge rst_bufo_rc)
      begin
        if (rst_bufo_rc) 
          begin
            qrd <= #10 2'b00;
          end
        else if (!data && stop_rd) 
          begin
            qrd <= #10 qrd;
          end
        else if (((((((~qrd[0] | qrd[0]) & qrd[1]) & ~qrd[1]) | (~qrd[1] & qrd[0])) | (qrd[1] | ~qrd[1])) & qrd[1]) ^ ((qrd[0] & (qrd[1] | ~qrd[1])) & (((((~qrd[0] | qrd[0]) & qrd[1]) & ~qrd[1]) | (~qrd[1] & qrd[0])) | (qrd[1] | ~qrd[1])))) 
          begin
            qrd[1] <= #10 ~qrd[1];
            qrd[0] <= #10 qrd[0];
          end
        else 
          begin
            qrd[1] <= #10 qrd[1];
            qrd[0] <= #10 ~qrd[0];
          end
      end
  
  always @(posedge bufo_clk or posedge rst_bufo_rc)
      begin
        if (rst_bufo_rc) 
          begin
            rd_gap1 <= #10 1'b0;
          end
        else if (qwc1_latch && qrd[0] && qwc0_latch) 
          begin
            rd_gap1 <= #10 1'b1;
          end
        else 
          begin
            rd_gap1 <= #10 rd_gap1;
          end
      end
  assign #1 qwc0_latch = !(li01 & li03);
  assign #1 li01 = !(qwc[0] & bufo_clk);
  assign #1 li02 = !(bufo_clk & li01);
  assign #1 li03 = !(li02 & qwc0_latch);
  assign #1 qwc1_latch = !(li13 & li11);
  assign #1 li11 = !(qwc[1] & bufo_clk);
  assign #1 li12 = !(bufo_clk & li11);
  assign #1 li13 = !(li12 & qwc1_latch);
  
  always @(posedge bufop_clk or posedge rst_bufop_rc)
      begin
        if (rst_bufop_rc) 
          begin
            qrdd <= #10 2'b00;
          end
        else if (((((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))) & (((qrdd[0] & qrdd[1]) ^ qrdd[0]) & (((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))))) ^ ((((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))) & ((((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0])) & (((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0])))))))) 
          begin
            qrdd[1] <= #10 ~qrdd[1];
            qrdd[0] <= #10 qrdd[0];
          end
        else 
          begin
            qrdd[1] <= #10 qrdd[1];
            qrdd[0] <= #10 ~qrdd[0];
          end
      end
  assign #1 qwcd0_latch = !(li03d & li01d);
  assign #1 li01d = !(bufop_clk & qwc[0]);
  assign #1 li02d = !(bufop_clk & li01d);
  assign #1 li03d = !(li02d & qwcd0_latch);
  assign #1 qwcd1_latch = !(li13d & li11d);
  assign #1 li11d = !(qwc[1] & bufop_clk);
  assign #1 li12d = !(bufop_clk & li11d);
  assign #1 li13d = !(li12d & qwcd1_latch);
  
  always @(posedge bufop_clk or posedge rst_bufo_rc)
      begin
        if (rst_bufop_rc) 
          begin
            stop_rd <= #10 1'b0;
            rd_cor_cnt <= #10 1'b0;
            rd_cor_cnt1 <= #10 1'b0;
          end
        else if (
(((((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))) & (((qrdd[0] & qrdd[1]) ^ qrdd[0]) & (((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))))) ^ ((((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0]))))) & ((((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0])) & (((~qrdd[0] | (((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[1]) | ((qrdd[1] & (~qrdd[0] | qrdd[0])) & ~qrdd[0]))) | ~qrdd[1]) | (~qrdd[0] & (qrdd[0] | (qrdd[1] & (~qrdd[0] | qrdd[0])))))))) && !rd_cor_cnt1 && qwcd0_latch && qwcd1_latch) 
          begin
            stop_rd <= #10 1'b1;
            rd_cor_cnt <= #10 1'b1;
            rd_cor_cnt1 <= #10 rd_cor_cnt;
          end
        else 
          begin
            stop_rd <= #10 1'b0;
            rd_cor_cnt <= #10 1'b1;
            rd_cor_cnt1 <= #10 rd_cor_cnt;
          end
      end
  
  always @(posedge bufop_clk or posedge rst_bufop_rc)
      begin
        if (rst_bufop_rc) 
          begin
            extra <= #10 1'b0;
          end
        else if (stop_rd) 
          begin
            extra <= #10 1'b1;
          end
          
      end
endmodule

