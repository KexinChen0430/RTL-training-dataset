module uparc_fetch(
	clk, 
	nrst, 
	i_pc, 
	i_jump_addr, 
	i_jump_valid, 
	i_except_valid, 
	i_except_haddr, 
	i_exec_stall, 
	i_mem_stall, 
	o_fetch_stall, 
	i_wait_stall, 
	o_bus_error, 
	o_addr_error, 
	i_nullify, 
	o_addr, 
	i_instr_dat, 
	o_rd_cmd, 
	i_busy, 
	i_err_align, 
	i_err_bus, 
	o_instr, 
	o_pc 
);
localparam [`UPARC_INSTR_WIDTH-1:0] NOP = 32'h0000_0000;
input wire				clk; 
input wire				nrst; 
input wire [`UPARC_ADDR_WIDTH-1:0]	i_pc; 
input wire [`UPARC_ADDR_WIDTH-1:0]	i_jump_addr; 
input wire				i_jump_valid; 
input wire				i_except_valid; 
input wire [`UPARC_ADDR_WIDTH-1:0]	i_except_haddr; 
input wire				i_exec_stall; 
input wire				i_mem_stall; 
output wire				o_fetch_stall; 
input wire				i_wait_stall; 
output wire				o_bus_error; 
output wire				o_addr_error; 
input wire				i_nullify; 
output reg [`UPARC_ADDR_WIDTH-1:0]	o_addr; 
input wire [`UPARC_INSTR_WIDTH-1:0]	i_instr_dat; 
output reg				o_rd_cmd; 
input wire				i_busy; 
input wire				i_err_align; 
input wire				i_err_bus; 
output wire [`UPARC_INSTR_WIDTH-1:0]	o_instr; 
output reg [`UPARC_ADDR_WIDTH-1:0]	o_pc; 
wire core_stall = i_exec_stall || i_mem_stall || o_fetch_stall || i_wait_stall;
assign o_fetch_stall = i_busy;
assign o_bus_error = i_err_bus | err_bus_r;
assign o_addr_error = i_err_align | err_align_r;
assign o_instr = (!i_jump_valid && !i_nullify && !i_except_valid ? i_instr_dat : NOP);
reg				err_bus_r; 
reg				err_align_r; 
wire [`UPARC_ADDR_WIDTH-1:0]	new_pc = !i_except_valid ?
					(!i_jump_valid ? i_pc : i_jump_addr) : i_except_haddr;
always @(posedge clk or negedge nrst)
begin
	if(!nrst) 
	begin
		o_addr <= {(`UPARC_ADDR_WIDTH){1'b0}};
		o_pc <= {(`UPARC_ADDR_WIDTH){1'b0}};
		o_rd_cmd <= 1'b0;
		err_align_r <= 1'b0;
		err_bus_r <= 1'b0;
	end
	else 
	begin
		o_rd_cmd <= 1'b0;
		err_bus_r <= err_bus_r | i_err_bus;
		err_align_r <= err_align_r | i_err_align;
		if(!core_stall) 
		begin
			err_align_r <= 1'b0;
			err_bus_r <= 1'b0;
			o_addr <= new_pc;
			o_pc <= new_pc;
			o_rd_cmd <= !i_nullify ? 1'b1 : 1'b0;
		end
	end
end
endmodule