
module endpoint_blk_plus_v1_14(pci_exp_txp,pci_exp_txn,pci_exp_rxp,pci_exp_rxn,trn_clk,
                               trn_reset_n,trn_lnk_up_n,trn_td,trn_trem_n,trn_tsof_n,
                               trn_teof_n,trn_tsrc_rdy_n,trn_tdst_rdy_n,trn_tdst_dsc_n,
                               trn_tsrc_dsc_n,trn_terrfwd_n,trn_tbuf_av,trn_rd,trn_rrem_n,
                               trn_rsof_n,trn_reof_n,trn_rsrc_rdy_n,trn_rsrc_dsc_n,
                               trn_rdst_rdy_n,trn_rerrfwd_n,trn_rnp_ok_n,trn_rbar_hit_n,
                               trn_rfc_nph_av,trn_rfc_npd_av,trn_rfc_ph_av,trn_rfc_pd_av,
                               trn_rcpl_streaming_n,cfg_do,cfg_rd_wr_done_n,cfg_di,
                               cfg_byte_en_n,cfg_dwaddr,cfg_wr_en_n,cfg_rd_en_n,cfg_err_ur_n,
                               cfg_err_cpl_rdy_n,cfg_err_cor_n,cfg_err_ecrc_n,
                               cfg_err_cpl_timeout_n,cfg_err_cpl_abort_n,
                               cfg_err_cpl_unexpect_n,cfg_err_posted_n,
                               cfg_err_tlp_cpl_header,cfg_err_locked_n,cfg_interrupt_n,
                               cfg_interrupt_rdy_n,cfg_interrupt_assert_n,cfg_interrupt_di,
                               cfg_interrupt_do,cfg_interrupt_mmenable,
                               cfg_interrupt_msienable,cfg_to_turnoff_n,cfg_pm_wake_n,
                               cfg_pcie_link_state_n,cfg_trn_pending_n,cfg_dsn,
                               cfg_bus_number,cfg_device_number,cfg_function_number,
                               cfg_status,cfg_command,cfg_dstatus,cfg_dcommand,cfg_lstatus,
                               cfg_lcommand,fast_train_simulation_only,sys_clk,sys_reset_n,
                               refclkout);


endmodule

