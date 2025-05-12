module or1200_pm(
	clk, rst, pic_wakeup, spr_write, spr_addr, spr_dat_i, spr_dat_o,
	pm_clksd, pm_cpustall, pm_dc_gate, pm_ic_gate, pm_dmmu_gate,
	pm_immu_gate, pm_tt_gate, pm_cpu_gate, pm_wakeup, pm_lvolt
);
input		clk;		
input		rst;		
input		pic_wakeup;	
input		spr_write;	
input	[31:0]	spr_addr;	
input	[31:0]	spr_dat_i;	
output	[31:0]	spr_dat_o;	
input		pm_cpustall;	
output	[3:0]	pm_clksd;	
output		pm_dc_gate;	
output		pm_ic_gate;	
output		pm_dmmu_gate;	
output		pm_immu_gate;	
output		pm_tt_gate;	
output		pm_cpu_gate;	
output		pm_wakeup;	
output		pm_lvolt;	
`ifdef OR1200_PM_IMPLEMENTED
reg	[3:0]	sdf;	
reg		dme;	
reg		sme;	
reg		dcge;	
wire		pmr_sel; 
`ifdef OR1200_PM_PARTIAL_DECODING
assign pmr_sel = (spr_addr[`OR1200_SPR_GROUP_BITS] == `OR1200_SPRGRP_PM) ? 1'b1 : 1'b0;
`else
assign pmr_sel = ((spr_addr[`OR1200_SPR_GROUP_BITS] == `OR1200_SPRGRP_PM) &&
		  (spr_addr[`OR1200_SPR_OFS_BITS] == `OR1200_PM_OFS_PMR)) ? 1'b1 : 1'b0;
`endif
always @(posedge clk or posedge rst)
	if (rst)
		{dcge, sme, dme, sdf} <= 7'b0;
	else if (pmr_sel && spr_write) begin
		sdf <= #1 spr_dat_i[`OR1200_PM_PMR_SDF];
		dme <= #1 spr_dat_i[`OR1200_PM_PMR_DME];
		sme <= #1 spr_dat_i[`OR1200_PM_PMR_SME];
		dcge <= #1 spr_dat_i[`OR1200_PM_PMR_DCGE];
	end
	else if (pic_wakeup) begin
		dme <= #1 1'b0;
		sme <= #1 1'b0;
	end
`ifdef OR1200_PM_READREGS
assign spr_dat_o[`OR1200_PM_PMR_SDF] = sdf;
assign spr_dat_o[`OR1200_PM_PMR_DME] = dme;
assign spr_dat_o[`OR1200_PM_PMR_SME] = sme;
assign spr_dat_o[`OR1200_PM_PMR_DCGE] = dcge;
`ifdef OR1200_PM_UNUSED_ZERO
assign spr_dat_o[`OR1200_PM_PMR_UNUSED] = 25'b0;
`endif
`endif
assign pm_clksd = sdf;
assign pm_cpu_gate = (dme | sme) & ~pic_wakeup;
assign pm_dc_gate = pm_cpu_gate;
assign pm_ic_gate = pm_cpu_gate;
assign pm_dmmu_gate = pm_cpu_gate;
assign pm_immu_gate = pm_cpu_gate;
assign pm_tt_gate = sme & ~pic_wakeup;
assign pm_wakeup = pic_wakeup;
assign pm_lvolt = pm_cpu_gate | pm_cpustall;
`else
assign pm_clksd = 4'b0;
assign pm_cpu_gate = 1'b0;
assign pm_dc_gate = 1'b0;
assign pm_ic_gate = 1'b0;
assign pm_dmmu_gate = 1'b0;
assign pm_immu_gate = 1'b0;
assign pm_tt_gate = 1'b0;
assign pm_wakeup = 1'b1;
assign pm_lvolt = 1'b0;
`ifdef OR1200_PM_READREGS
assign spr_dat_o[`OR1200_PM_PMR_SDF] = 4'b0;
assign spr_dat_o[`OR1200_PM_PMR_DME] = 1'b0;
assign spr_dat_o[`OR1200_PM_PMR_SME] = 1'b0;
assign spr_dat_o[`OR1200_PM_PMR_DCGE] = 1'b0;
`ifdef OR1200_PM_UNUSED_ZERO
assign spr_dat_o[`OR1200_PM_PMR_UNUSED] = 25'b0;
`endif
`endif
`endif
endmodule