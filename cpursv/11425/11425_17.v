
module mpfe_rst(input  bus_clk,
                input  pll_locked,
                input  cal_success,
                input  init_done,
                input  pcie_perstn,
                input  cpu_resetn,
                input  pcie_ready,
                output global_reset_n,
                output mpfe_reset_n,
                output ctrl_reset_n);

  localparam  STOP_COUNT = 26'h3ffffff;
  reg  mpfe_reg[1:0];

  assign mpfe_reset_n = mpfe_reg[1];
  reg  ctrl_reg[1:0];

  assign ctrl_reset_n = ctrl_reg[1];
  reg  [25:0] reset_timer;

  reg  pcie_perstn_sync[1:0];

  reg  cpu_resetn_sync[1:0];

  wire 
       timer_resetn = pcie_perstn_sync[1] & cpu_resetn_sync[1];

  
  always @(posedge bus_clk or negedge cpu_resetn)
      begin
        if (~cpu_resetn) 
          begin
            cpu_resetn_sync[0] <= 0;
            cpu_resetn_sync[1] <= 0;
          end
        else 
          begin
            cpu_resetn_sync[0] <= 1;
            cpu_resetn_sync[1] <= cpu_resetn_sync[0];
          end
      end
  
  always @(posedge bus_clk or negedge pcie_perstn)
      begin
        if (~pcie_perstn) 
          begin
            pcie_perstn_sync[0] <= 0;
            pcie_perstn_sync[1] <= 0;
          end
        else 
          begin
            pcie_perstn_sync[0] <= 1;
            pcie_perstn_sync[1] <= pcie_perstn_sync[0];
          end
      end
  
  always @(posedge bus_clk or negedge timer_resetn)
      begin
        if (~timer_resetn) 
          begin
            reset_timer <= 0;
          end
        else if (reset_timer == STOP_COUNT) 
          begin
            reset_timer <= STOP_COUNT;
          end
        else 
          begin
            reset_timer <= 1'b1+reset_timer;
          end
      end
  assign global_reset_n = reset_timer == STOP_COUNT;
  wire 
       mpfe_arstn = (pll_locked & global_reset_n) & (cal_success & pcie_ready);

  
  always @(posedge bus_clk or negedge mpfe_arstn)
      begin
        if (~mpfe_arstn) 
          begin
            mpfe_reg[0] <= 0;
            mpfe_reg[1] <= 0;
          end
        else 
          begin
            mpfe_reg[0] <= 1;
            mpfe_reg[1] <= mpfe_reg[0];
          end
      end
  wire 
       ctrl_arstn = ((pcie_ready & init_done) & cal_success) & (pll_locked & global_reset_n);

  
  always @(posedge bus_clk or negedge ctrl_arstn)
      begin
        if (~ctrl_arstn) 
          begin
            ctrl_reg[0] <= 0;
            ctrl_reg[1] <= 0;
          end
        else 
          begin
            ctrl_reg[0] <= 1;
            ctrl_reg[1] <= ctrl_reg[0];
          end
      end
endmodule

