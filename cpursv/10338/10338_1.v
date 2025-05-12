
module or1200_pm(clk,rst,pic_wakeup,spr_write,spr_addr,spr_dat_i,spr_dat_o,
                 pm_clksd,pm_cpustall,pm_dc_gate,pm_ic_gate,pm_dmmu_gate,
                 pm_immu_gate,pm_tt_gate,pm_cpu_gate,pm_wakeup,pm_lvolt);

  input  clk;
  input  rst;
  input  pic_wakeup;
  input  spr_write;
  input  [31:0] spr_addr;
  input  [31:0] spr_dat_i;
  output [31:0] spr_dat_o;
  input  pm_cpustall;
  output [3:0] pm_clksd;
  output pm_dc_gate;
  output pm_ic_gate;
  output pm_dmmu_gate;
  output pm_immu_gate;
  output pm_tt_gate;
  output pm_cpu_gate;
  output pm_wakeup;
  output pm_lvolt;

  assign pm_clksd = 4'b0;
  assign pm_cpu_gate = 1'b0;
  assign pm_dc_gate = 1'b0;
  assign pm_ic_gate = 1'b0;
  assign pm_dmmu_gate = 1'b0;
  assign pm_immu_gate = 1'b0;
  assign pm_tt_gate = 1'b0;
  assign pm_wakeup = 1'b1;
  assign pm_lvolt = 1'b0;
endmodule

