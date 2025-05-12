module reset(
	input	core_clk,
	input	sample_clk,
	input	sd_clk,
	input	usb_clk,
	input	sys_rst,
	input	sys_clr,
	output	core_rst,
	output	sample_rst,
	output	sd_rst,
	output	sdram_rst_,
	output	cfg_rst,
	output	usb_rst
);
wire	clr_rst;
assign clr_rst = sys_rst | sys_clr;
reg	[3:0]	core_rst_reg;
wire	[3:0]	core_rst_reg_nxt;
assign core_rst = core_rst_reg[3];
assign core_rst_reg_nxt = {core_rst_reg[2:0], 1'b0};
always @(posedge core_clk or posedge clr_rst)
begin
	if (clr_rst)
		core_rst_reg <= `D 4'b1111;
	else
		core_rst_reg <= `D core_rst_reg_nxt;
end
reg	[17:0]	sample_rst_reg;
wire	[17:0]	sample_rst_reg_nxt;
assign sample_rst = sample_rst_reg[17];
assign sample_rst_reg_nxt = {sample_rst_reg[16:0], 1'b0};
always @(posedge sample_clk or posedge clr_rst)
begin
	if (clr_rst)
		sample_rst_reg <= `D 18'b111111111111111111;
	else
		sample_rst_reg <= `D sample_rst_reg_nxt;
end
reg	[3:0]	sd_rst_reg;
wire	[3:0]	sd_rst_reg_nxt;
assign sd_rst = sd_rst_reg[3];
assign sd_rst_reg_nxt = {sd_rst_reg[2:0], 1'b0};
always @(posedge sd_clk or posedge clr_rst)
begin
	if (clr_rst)
		sd_rst_reg <= `D 4'b1111;
	else
		sd_rst_reg <= `D sd_rst_reg_nxt;
end
reg	[3:0]	sdram_rst_reg = 4'b0;
wire	[3:0]	sdram_rst_reg_nxt;
assign sdram_rst_ = sdram_rst_reg[3];
assign sdram_rst_reg_nxt = {sdram_rst_reg[2:0], 1'b1};
always @(posedge sd_clk)
begin
		sdram_rst_reg <= `D sdram_rst_reg_nxt;
end
reg	[3:0]	cfg_rst_reg;
wire	[3:0]	cfg_rst_reg_nxt;
assign cfg_rst = cfg_rst_reg[3];
assign cfg_rst_reg_nxt = {cfg_rst_reg[2:0], 1'b0};
always @(posedge usb_clk or posedge sys_rst)
begin
	if (sys_rst)
		cfg_rst_reg <= `D 4'b1111;
	else
		cfg_rst_reg <= `D cfg_rst_reg_nxt;
end
reg	[3:0]	usb_rst_reg;
wire	[3:0]	usb_rst_reg_nxt;
assign usb_rst = usb_rst_reg[3];
assign usb_rst_reg_nxt = {usb_rst_reg[2:0], 1'b0};
always @(posedge usb_clk or posedge clr_rst)
begin
	if (clr_rst)
		usb_rst_reg <= `D 4'b1111;
	else
		usb_rst_reg <= `D usb_rst_reg_nxt;
end
endmodule