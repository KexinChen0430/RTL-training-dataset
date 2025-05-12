module hpdmc_ctlif #( 
	parameter csr_addr = 4'h0 
) (
	input sys_clk, 
	input sys_rst, 
	input [13:0] csr_a, 
	input csr_we, 
	input [31:0] csr_di, 
	output reg [31:0] csr_do, 
	output reg bypass, 
	output reg sdram_rst, 
	output reg sdram_cke, 
	output reg sdram_cs_n, 
	output reg sdram_we_n, 
	output reg sdram_cas_n, 
	output reg sdram_ras_n, 
	output reg [12:0] sdram_adr, 
	output reg [1:0] sdram_ba, 
	output reg [2:0] tim_rp, 
	output reg [2:0] tim_rcd, 
	output reg tim_cas, 
	output reg [10:0] tim_refi, 
	output reg [3:0] tim_rfc, 
	output reg [1:0] tim_wr, 
	output reg idelay_rst, 
	output reg idelay_ce, 
	output reg idelay_inc, 
	output reg dqs_psen, 
	output reg dqs_psincdec, 
	input dqs_psdone, 
	input [1:0] pll_stat 
);
reg psready; 
always @(posedge sys_clk) begin 
	if(dqs_psdone) 
		psready <= 1'b1; 
	else if(dqs_psen) 
		psready <= 1'b0; 
end
wire csr_selected = csr_a[13:10] == csr_addr; 
reg [1:0] pll_stat1; 
reg [1:0] pll_stat2; 
always @(posedge sys_clk) begin 
	pll_stat1 <= pll_stat; 
	pll_stat2 <= pll_stat1; 
end
always @(posedge sys_clk) begin 
	if(sys_rst) begin 
	end else begin
	end
end
endmodule