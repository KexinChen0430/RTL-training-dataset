
module fifo_reset_oserdese1_vlog(rst_bufo_p,rst_bufo_rc,rst_bufg_p,rst_bufg_wc,rst_cntr,
                                 bufg_clk,bufo_clk,clkdiv,rst,divide_2,bufop_clk,rst_bufop_rc);

  input  rst_cntr;
  input  rst;
  input  bufg_clk;
  input  bufo_clk;
  input  clkdiv;
  input  bufop_clk;
  input  divide_2;
  output rst_bufo_p;
  output rst_bufo_rc;
  output rst_bufg_p;
  output rst_bufg_wc;
  output rst_bufop_rc;
  reg  [1:0] clkdiv_pipe;
  reg  bufg_pipe;
  reg  rst_cntr_reg;
  reg  [2:0] bufo_rst_p;
  reg  [2:0] bufo_rst_rc;
  reg  [1:0] bufop_rst_rc;
  reg  [1:0] bufg_rst_p;
  reg  [1:0] bufg_rst_wc;
  wire bufg_clkdiv_latch;
  wire ltint1,ltint2,ltint3;
  wire latch_in;

  
  always @(posedge bufg_clk or posedge rst)
      begin
        if (rst) 
          begin
            rst_cntr_reg <= #10 1'b0;
          end
        else 
          begin
            rst_cntr_reg <= #10 rst_cntr;
          end
      end
  
  always @(posedge clkdiv or posedge rst)
      begin
        if (rst) 
          begin
            clkdiv_pipe <= #10 2'b11;
          end
        else 
          begin
            clkdiv_pipe <= #10 {clkdiv_pipe[0],1'b0};
          end
      end
  assign #1 latch_in = clkdiv_pipe[1];
  assign #1 bufg_clkdiv_latch = !(ltint3 && ltint1);
  assign #1 ltint1 = !(latch_in && bufg_clk);
  assign #1 ltint2 = !(ltint1 && bufg_clk);
  assign #1 ltint3 = !(bufg_clkdiv_latch && ltint2);
  
  always @(posedge bufg_clk or posedge rst)
      begin
        if (rst) 
          begin
            bufg_pipe <= #10 1'b1;
          end
        else 
          begin
            bufg_pipe <= #10 bufg_clkdiv_latch;
          end
      end
  
  always @(posedge bufg_clk or posedge rst)
      begin
        if (rst) 
          begin
            bufg_rst_p <= #10 2'b11;
          end
        else 
          begin
            bufg_rst_p <= #10 {bufg_rst_p[0],bufg_pipe};
          end
      end
  
  always @(posedge bufg_clk or posedge rst_cntr or posedge rst)
      begin
        if (rst || rst_cntr) 
          begin
            bufg_rst_wc <= #10 2'b11;
          end
        else 
          begin
            bufg_rst_wc <= #10 {bufg_rst_wc[0],bufg_pipe};
          end
      end
  
  always @(posedge bufo_clk or posedge rst)
      begin
        if (rst) 
          begin
            bufo_rst_p <= #10 3'b111;
          end
        else 
          begin
            bufo_rst_p <= #10 {bufo_rst_p[1:0],bufg_pipe};
          end
      end
  
  always @(posedge bufo_clk or posedge rst or posedge rst_cntr)
      begin
        if (rst || rst_cntr) 
          begin
            bufo_rst_rc <= #10 3'b111;
          end
        else 
          begin
            bufo_rst_rc <= #10 {bufo_rst_rc[1:0],bufg_pipe};
          end
      end
  
  always @(posedge bufop_clk or posedge rst or posedge rst_cntr)
      begin
        if (rst || rst_cntr) 
          begin
            bufop_rst_rc <= #10 2'b11;
          end
        else 
          begin
            bufop_rst_rc <= #10 {bufop_rst_rc[0],bufg_pipe};
          end
      end
  assign rst_bufo_rc = bufo_rst_rc[1];
  assign rst_bufo_p = bufo_rst_p[1];
  assign rst_bufop_rc = bufop_rst_rc[1];
  assign rst_bufg_wc = bufg_rst_wc[1];
  assign rst_bufg_p = bufg_rst_p[1];
endmodule

