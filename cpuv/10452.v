module top( 
	input fclk, 
	output clkz_out, 
	input clkz_in, 
	input iorq_n, 
	input mreq_n, 
	input rd_n, 
	input wr_n, 
	input m1_n, 
	input rfsh_n, 
	output int_n, 
	output nmi_n, 
	output wait_n, 
	output res, 
	inout [7:0] d, 
	input [15:0] a, 
	output csrom, 
	output romoe_n, 
	output romwe_n, 
	output rompg0_n, 
	output dos_n, 
	output rompg2, 
	output rompg3, 
	output rompg4, 
	input iorqge1, 
	input iorqge2, 
	output iorq1_n, 
	output iorq2_n, 
	inout [15:0] rd, 
	output [9:0] ra, 
	output rwe_n, 
	output rucas_n, 
	output rlcas_n, 
	output rras0_n, 
	output rras1_n, 
	output [1:0] vred, 
	output [1:0] vgrn, 
	output [1:0] vblu, 
	output vhsync, 
	output vvsync, 
	output vcsync, 
	output ay_clk, 
	output ay_bdir, 
	output ay_bc1, 
	output beep, 
	output [2:0] ide_a, 
	inout [15:0] ide_d, 
	output ide_dir, 
	input ide_rdy, 
	output ide_cs0_n, 
	output ide_cs1_n, 
	output ide_rs_n, 
	output ide_rd_n, 
	output ide_wr_n, 
	output vg_clk, 
	output vg_cs_n, 
	output vg_res_n, 
	output vg_hrdy, 
	output vg_rclk, 
	output vg_rawr, 
	output [1:0] vg_a, 
	output vg_wrd, 
	output vg_side, 
	input step, 
	input vg_sl, 
	input vg_sr, 
	input vg_tr43, 
	input rdat_b_n, 
	input vg_wf_de, 
	input vg_drq, 
	input vg_irq, 
	input vg_wd, 
	output sdcs_n, 
	output sddo, 
	output sdclk, 
	input sddi, 
	input spics_n, 
	input spick, 
	input spido, 
	output spidi, 
	output spiint_n 
);
	assign clkz_out = 1'b0; 
	assign int_n = 1'bZ; 
	assign nmi_n = 1'bZ; 
	assign wait_n = 1'bZ; 
	assign res = 1'bZ; 
	assign d = 8'bZZZZ_ZZZZ; 
	assign csrom = 1'bZ; 
	assign romoe_n = 1'b1; 
	assign romwe_n = 1'b1; 
	assign rompg0_n = 1'b1; 
	assign dos_n = 1'b1; 
	assign rompg2 = 1'b1; 
	assign rompg3 = 1'b1; 
	assign rompg4 = 1'b1; 
	assign iorq1_n = 1'b1; 
	assign iorq2_n = 1'b1; 
	assign rd = 16'hZZZZ; 
	assign ra = 10'd0; 
	assign rwe_n = 1'b1; 
	assign rucas_n = 1'b1; 
	assign rlcas_n = 1'b1; 
	assign rras0_n = 1'b1; 
	assign rras1_n = 1'b1; 
	assign ay_clk = 1'b0; 
	assign ay_bdir = 1'b0; 
	assign ay_bc1  = 1'b0; 
	assign beep = 1'b0; 
	assign ide_a = 3'bZZZ; 
	assign ide_d = 16'hZZZZ; 
	assign ide_dir = 1'b0; 
	assign ide_cs0_n = 1'b1; 
	assign ide_cs1_n = 1'b1; 
	assign ide_rs_n = 1'b0; 
	assign ide_rd_n = 1'b1; 
	assign ide_wr_n = 1'b1; 
	assign vg_clk = 1'b0; 
	assign vg_cs_n = 1'b1; 
	assign vg_res_n = 1'b0; 
	assign vg_hdry = 1'b0; 
	assign vg_rclk = 1'b0; 
	assign vg_rawr = 1'b0; 
	assign vg_a a= 2'b00; 
	assign vg_wrd = 1'b0; 
	assign vg_side = 1'b0; 
	assign sdcs_n = 1'b1; 
	assign sddo = 1'b1; 
	assign sdclk = 1'b0; 
	assign spidi = 1'bZ; 
	assign spiint_n = 1'b1; 
endmodule 