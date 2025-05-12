module or1200_ic_fsm(
	clk, rst,
	ic_en, icqmem_cycstb_i, icqmem_ci_i,
	tagcomp_miss,
	biudata_valid, biudata_error,
        start_addr, saved_addr,
	icram_we, tag_we,
        biu_read,
        first_hit_ack, first_miss_ack, first_miss_err,
	burst
);