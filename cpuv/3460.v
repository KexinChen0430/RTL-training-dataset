module uparc_memory_access(
	clk,
	nrst,
	i_exec_stall,
	o_mem_stall,
	i_fetch_stall,
	i_wait_stall,
	o_bus_error,
	o_addr_error,
	i_nullify,
	lsu_addr,
	lsu_wdata,
	lsu_rdata,
	lsu_cmd,
	lsu_rnw,
	lsu_busy,
	lsu_err_align,
	lsu_err_bus,
	i_rd_no,
	i_alu_result,
	i_lsu_op,
	i_lsu_lns,
	i_lsu_ext,
	i_mem_data,
	o_rd_no,
	o_rd_val
);
`include "uparc_reg_names.vh"
localparam [3:0] MUX_RD_ALU		= 4'b0000;	
localparam [3:0] MUX_RD_BYTE_SE		= 4'b1000;	
localparam [3:0] MUX_RD_BYTE_ZE		= 4'b1001;	
localparam [3:0] MUX_RD_HWORD_SE	= 4'b1010;	
localparam [3:0] MUX_RD_HWORD_ZE	= 4'b1011;	
localparam [3:0] MUX_RD_WORD		= 4'b1100;	
input wire				clk;
input wire				nrst;
input wire				i_exec_stall;
output wire				o_mem_stall;
input wire				i_fetch_stall;
input wire				i_wait_stall;
output wire				o_bus_error;
output wire				o_addr_error;
input wire				i_nullify;
output reg [`UPARC_ADDR_WIDTH-1:0]	lsu_addr;
output reg [`UPARC_DATA_WIDTH-1:0]	lsu_wdata;
input wire [`UPARC_DATA_WIDTH-1:0]	lsu_rdata;
output reg [1:0]			lsu_cmd;
output reg				lsu_rnw;
input wire				lsu_busy;
input wire				lsu_err_align;
input wire				lsu_err_bus;
input wire [`UPARC_REGNO_WIDTH-1:0]	i_rd_no;
input wire [`UPARC_REG_WIDTH-1:0]	i_alu_result;
input wire [`UPARC_LSUOP_WIDTH-1:0]	i_lsu_op;
input wire				i_lsu_lns;
input wire				i_lsu_ext;
input wire [`UPARC_DATA_WIDTH-1:0]	i_mem_data;
output reg [`UPARC_REGNO_WIDTH-1:0]	o_rd_no;
output reg [`UPARC_REG_WIDTH-1:0]	o_rd_val;
wire core_stall = i_exec_stall || o_mem_stall || i_fetch_stall || i_wait_stall;
assign o_mem_stall = lsu_busy;
assign o_bus_error = lsu_err_bus | lsu_err_bus_r;
assign o_addr_error = lsu_err_align | lsu_err_align_r;
reg				lsu_err_bus_r;
reg				lsu_err_align_r;
reg [3:0]			lsu_mux;	
reg [`UPARC_REG_WIDTH-1:0]	alu_result;
always @(posedge clk or negedge nrst)
begin
	if(!nrst)
	begin
		lsu_addr <= {(`UPARC_ADDR_WIDTH){1'b0}};
		lsu_wdata <= {(`UPARC_DATA_WIDTH){1'b0}};
		lsu_cmd <= `UPARC_LSU_IDLE;
		lsu_rnw <= 1'b0;
		lsu_mux <= MUX_RD_ALU;
		alu_result <= {(`UPARC_REG_WIDTH){1'b0}};
		o_rd_no <= {(`UPARC_REGNO_WIDTH){1'b0}};
		lsu_err_align_r <= 1'b0;
		lsu_err_bus_r <= 1'b0;
	end
	else
	begin
		lsu_cmd <= `UPARC_LSU_IDLE;
		lsu_err_bus_r <= lsu_err_bus_r | lsu_err_bus;
		lsu_err_align_r <= lsu_err_align_r | lsu_err_align;
		if(!core_stall)
		begin
			o_rd_no <= !i_nullify ? i_rd_no : {(`UPARC_REGNO_WIDTH){1'b0}};
			lsu_err_bus_r <= 1'b0;
			lsu_err_align_r <= 1'b0;
			alu_result <= i_alu_result;
			lsu_addr <= i_alu_result;
			lsu_wdata <= i_mem_data;
			lsu_cmd <= !i_nullify ? i_lsu_op : `UPARC_LSU_IDLE;
			lsu_rnw <= i_lsu_lns;
			if(i_lsu_op == `UPARC_LSU_BYTE && i_lsu_ext == 1'b1)
				lsu_mux <= MUX_RD_BYTE_SE;
			else if(i_lsu_op == `UPARC_LSU_BYTE && i_lsu_ext == 1'b0)
				lsu_mux <= MUX_RD_BYTE_ZE;
			else if(i_lsu_op == `UPARC_LSU_HWORD && i_lsu_ext == 1'b1)
				lsu_mux <= MUX_RD_HWORD_SE;
			else if(i_lsu_op == `UPARC_LSU_HWORD && i_lsu_ext == 1'b0)
				lsu_mux <= MUX_RD_HWORD_ZE;
			else if(i_lsu_op == `UPARC_LSU_WORD)
				lsu_mux <= MUX_RD_WORD;
			else
				lsu_mux <= MUX_RD_ALU;
		end
	end
end
always @(*)
begin
	case(lsu_mux)
	MUX_RD_BYTE_SE: o_rd_val = { {24{lsu_rdata[7]}}, lsu_rdata[7:0] };
	MUX_RD_BYTE_ZE: o_rd_val = { 24'b0, lsu_rdata[7:0] };
	MUX_RD_HWORD_SE: o_rd_val = { {16{lsu_rdata[15]}}, lsu_rdata[15:0] };
	MUX_RD_HWORD_ZE: o_rd_val = { 16'b0, lsu_rdata[15:0] };
	MUX_RD_WORD: o_rd_val = lsu_rdata;
	default: o_rd_val = alu_result;
	endcase
end
endmodule