
module v6_pcie_v1_7(pci_exp_txp,pci_exp_txn,pci_exp_rxp,pci_exp_rxn,trn_clk,
                    trn_reset_n,trn_lnk_up_n,trn_tbuf_av,trn_tcfg_req_n,
                    trn_terr_drop_n,trn_tdst_rdy_n,trn_td,trn_trem_n,trn_tsof_n,
                    trn_teof_n,trn_tsrc_rdy_n,trn_tsrc_dsc_n,trn_terrfwd_n,
                    trn_tcfg_gnt_n,trn_tstr_n,trn_rd,trn_rrem_n,trn_rsof_n,
                    trn_reof_n,trn_rsrc_rdy_n,trn_rsrc_dsc_n,trn_rerrfwd_n,
                    trn_rbar_hit_n,trn_rdst_rdy_n,trn_rnp_ok_n,trn_fc_cpld,
                    trn_fc_cplh,trn_fc_npd,trn_fc_nph,trn_fc_pd,trn_fc_ph,
                    trn_fc_sel,cfg_do,cfg_rd_wr_done_n,cfg_di,cfg_byte_en_n,
                    cfg_dwaddr,cfg_wr_en_n,cfg_rd_en_n,cfg_err_cor_n,cfg_err_ur_n,
                    cfg_err_ecrc_n,cfg_err_cpl_timeout_n,cfg_err_cpl_abort_n,
                    cfg_err_cpl_unexpect_n,cfg_err_posted_n,cfg_err_locked_n,
                    cfg_err_tlp_cpl_header,cfg_err_cpl_rdy_n,cfg_interrupt_n,
                    cfg_interrupt_rdy_n,cfg_interrupt_assert_n,cfg_interrupt_di,
                    cfg_interrupt_do,cfg_interrupt_mmenable,
                    cfg_interrupt_msienable,cfg_interrupt_msixenable,
                    cfg_interrupt_msixfm,cfg_turnoff_ok_n,cfg_to_turnoff_n,
                    cfg_trn_pending_n,cfg_pm_wake_n,cfg_bus_number,
                    cfg_device_number,cfg_function_number,cfg_status,cfg_command,
                    cfg_dstatus,cfg_dcommand,cfg_lstatus,cfg_lcommand,
                    cfg_dcommand2,cfg_pcie_link_state_n,cfg_dsn,cfg_pmcsr_pme_en,
                    cfg_pmcsr_pme_status,cfg_pmcsr_powerstate,
                    pl_initial_link_width,pl_lane_reversal_mode,
                    pl_link_gen2_capable,pl_link_partner_gen2_supported,
                    pl_link_upcfg_capable,pl_ltssm_state,pl_received_hot_rst,
                    pl_sel_link_rate,pl_sel_link_width,pl_directed_link_auton,
                    pl_directed_link_change,pl_directed_link_speed,
                    pl_directed_link_width,pl_upstream_prefer_deemph,sys_clk,
                    sys_reset_n);

  output [4+(-1):0] pci_exp_txp;
  output [4+(-1):0] pci_exp_txn;
  input  [4+(-1):0] pci_exp_rxp;
  input  [4+(-1):0] pci_exp_rxn;
  output trn_clk;
  output trn_reset_n;
  output trn_lnk_up_n;
  output [5:0] trn_tbuf_av;
  output trn_tcfg_req_n;
  output trn_terr_drop_n;
  output trn_tdst_rdy_n;
  input  [63:0] trn_td;
  input  trn_trem_n;
  input  trn_tsof_n;
  input  trn_teof_n;
  input  trn_tsrc_rdy_n;
  input  trn_tsrc_dsc_n;
  input  trn_terrfwd_n;
  input  trn_tcfg_gnt_n;
  input  trn_tstr_n;
  output [63:0] trn_rd;
  output trn_rrem_n;
  output trn_rsof_n;
  output trn_reof_n;
  output trn_rsrc_rdy_n;
  output trn_rsrc_dsc_n;
  output trn_rerrfwd_n;
  output [6:0] trn_rbar_hit_n;
  input  trn_rdst_rdy_n;
  input  trn_rnp_ok_n;
  output [11:0] trn_fc_cpld;
  output [7:0] trn_fc_cplh;
  output [11:0] trn_fc_npd;
  output [7:0] trn_fc_nph;
  output [11:0] trn_fc_pd;
  output [7:0] trn_fc_ph;
  input  [2:0] trn_fc_sel;
  output [31:0] cfg_do;
  output cfg_rd_wr_done_n;
  input  [31:0] cfg_di;
  input  [3:0] cfg_byte_en_n;
  input  [9:0] cfg_dwaddr;
  input  cfg_wr_en_n;
  input  cfg_rd_en_n;
  input  cfg_err_cor_n;
  input  cfg_err_ur_n;
  input  cfg_err_ecrc_n;
  input  cfg_err_cpl_timeout_n;
  input  cfg_err_cpl_abort_n;
  input  cfg_err_cpl_unexpect_n;
  input  cfg_err_posted_n;
  input  cfg_err_locked_n;
  input  [47:0] cfg_err_tlp_cpl_header;
  output cfg_err_cpl_rdy_n;
  input  cfg_interrupt_n;
  output cfg_interrupt_rdy_n;
  input  cfg_interrupt_assert_n;
  input  [7:0] cfg_interrupt_di;
  output [7:0] cfg_interrupt_do;
  output [2:0] cfg_interrupt_mmenable;
  output cfg_interrupt_msienable;
  output cfg_interrupt_msixenable;
  output cfg_interrupt_msixfm;
  input  cfg_turnoff_ok_n;
  output cfg_to_turnoff_n;
  input  cfg_trn_pending_n;
  input  cfg_pm_wake_n;
  output [7:0] cfg_bus_number;
  output [4:0] cfg_device_number;
  output [2:0] cfg_function_number;
  output [15:0] cfg_status;
  output [15:0] cfg_command;
  output [15:0] cfg_dstatus;
  output [15:0] cfg_dcommand;
  output [15:0] cfg_lstatus;
  output [15:0] cfg_lcommand;
  output [15:0] cfg_dcommand2;
  output [2:0] cfg_pcie_link_state_n;
  input  [63:0] cfg_dsn;
  output cfg_pmcsr_pme_en;
  output cfg_pmcsr_pme_status;
  output [1:0] cfg_pmcsr_powerstate;
  output [2:0] pl_initial_link_width;
  output [1:0] pl_lane_reversal_mode;
  output pl_link_gen2_capable;
  output pl_link_partner_gen2_supported;
  output pl_link_upcfg_capable;
  output [5:0] pl_ltssm_state;
  output pl_received_hot_rst;
  output pl_sel_link_rate;
  output [1:0] pl_sel_link_width;
  input  pl_directed_link_auton;
  input  [1:0] pl_directed_link_change;
  input  pl_directed_link_speed;
  input  [1:0] pl_directed_link_width;
  input  pl_upstream_prefer_deemph;
  input  sys_clk;
  input  sys_reset_n;


endmodule

