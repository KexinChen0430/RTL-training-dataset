
module ddr2(local_address,local_write_req,local_read_req,
            local_burstbegin,local_wdata,local_be,local_size,
            global_reset_n,pll_ref_clk,soft_reset_n,local_ready,
            local_rdata,local_rdata_valid,reset_request_n,mem_odt,
            mem_cs_n,mem_cke,mem_addr,mem_ba,mem_ras_n,mem_cas_n,mem_we_n,
            mem_dm,local_refresh_ack,local_wdata_req,local_init_done,
            reset_phy_clk_n,dll_reference_clk,dqs_delay_ctrl_export,
            phy_clk,aux_full_rate_clk,aux_half_rate_clk,mem_clk,mem_clk_n,
            mem_dq,mem_dqs,mem_dqsn);


endmodule

