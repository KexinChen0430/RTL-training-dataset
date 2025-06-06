module riscv_fetch
#(
     parameter SUPPORT_MMU      = 1
)
(
     input           clk_i
    ,input           rst_i
    ,input           fetch_accept_i
    ,input           icache_accept_i
    ,input           icache_valid_i
    ,input           icache_error_i
    ,input  [ 31:0]  icache_inst_i
    ,input           icache_page_fault_i
    ,input           fetch_invalidate_i
    ,input           branch_request_i
    ,input  [ 31:0]  branch_pc_i
    ,input  [  1:0]  branch_priv_i
    ,output          fetch_valid_o
    ,output [ 31:0]  fetch_instr_o
    ,output [ 31:0]  fetch_pc_o
    ,output          fetch_fault_fetch_o
    ,output          fetch_fault_page_o
    ,output          icache_rd_o
    ,output          icache_flush_o
    ,output          icache_invalidate_o
    ,output [ 31:0]  icache_pc_o
    ,output [  1:0]  icache_priv_o
    ,output          squash_decode_o
);
`include "riscv_defs.v"
reg         active_q;
wire        icache_busy_w;
wire        stall_w       = !fetch_accept_i || icache_busy_w || !icache_accept_i;
reg         branch_q;
reg [31:0]  branch_pc_q;
reg [1:0]   branch_priv_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    branch_q       <= 1'b0;
    branch_pc_q    <= 32'b0;
    branch_priv_q  <= `PRIV_MACHINE;
end
else if (branch_request_i)
begin
    branch_q       <= 1'b1;
    branch_pc_q    <= branch_pc_i;
    branch_priv_q  <= branch_priv_i;
end
else if (icache_rd_o && icache_accept_i)
begin
    branch_q       <= 1'b0;
    branch_pc_q    <= 32'b0;
end
wire        branch_w      = branch_q;
wire [31:0] branch_pc_w   = branch_pc_q;
wire [1:0]  branch_priv_w = branch_priv_q;
assign squash_decode_o    = branch_request_i;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    active_q    <= 1'b0;
else if (branch_w && ~stall_w)
    active_q    <= 1'b1;
reg stall_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    stall_q    <= 1'b0;
else
    stall_q    <= stall_w;
reg icache_fetch_q;
reg icache_invalidate_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    icache_fetch_q <= 1'b0;
else if (icache_rd_o && icache_accept_i)
    icache_fetch_q <= 1'b1;
else if (icache_valid_i)
    icache_fetch_q <= 1'b0;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    icache_invalidate_q <= 1'b0;
else if (icache_invalidate_o && !icache_accept_i)
    icache_invalidate_q <= 1'b1;
else
    icache_invalidate_q <= 1'b0;
reg [31:0]  pc_f_q;
reg [31:0]  pc_d_q;
wire [31:0] icache_pc_w;
wire [1:0]  icache_priv_w;
wire        fetch_resp_drop_w;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    pc_f_q  <= 32'b0;
else if (branch_w && ~stall_w)
    pc_f_q  <= branch_pc_w;
else if (!stall_w)
    pc_f_q  <= {icache_pc_w[31:2],2'b0} + 32'd4;
reg [1:0] priv_f_q;
reg       branch_d_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    priv_f_q  <= `PRIV_MACHINE;
else if (branch_w && ~stall_w)
    priv_f_q  <= branch_priv_w;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    branch_d_q  <= 1'b0;
else if (branch_w && ~stall_w)
    branch_d_q  <= 1'b1;
else if (!stall_w)
    branch_d_q  <= 1'b0;
assign icache_pc_w       = pc_f_q;
assign icache_priv_w     = priv_f_q;
assign fetch_resp_drop_w = branch_w | branch_d_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    pc_d_q <= 32'b0;
else if (icache_rd_o && icache_accept_i)
    pc_d_q <= icache_pc_w;
assign icache_rd_o         = active_q & fetch_accept_i & !icache_busy_w;
assign icache_pc_o         = {icache_pc_w[31:2],2'b0};
assign icache_priv_o       = icache_priv_w;
assign icache_flush_o      = fetch_invalidate_i | icache_invalidate_q;
assign icache_invalidate_o = 1'b0;
assign icache_busy_w       =  icache_fetch_q && !icache_valid_i;
reg [65:0]  skid_buffer_q;
reg         skid_valid_q;
always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    skid_buffer_q  <= 66'b0;
    skid_valid_q   <= 1'b0;
end
else if (fetch_valid_o && !fetch_accept_i)
begin
    skid_valid_q  <= 1'b1;
    skid_buffer_q <= {fetch_fault_page_o, fetch_fault_fetch_o, fetch_pc_o, fetch_instr_o};
end
else
begin
    skid_valid_q  <= 1'b0;
    skid_buffer_q <= 66'b0;
end
assign fetch_valid_o       = (icache_valid_i || skid_valid_q) & !fetch_resp_drop_w;
assign fetch_pc_o          = skid_valid_q ? skid_buffer_q[63:32] : {pc_d_q[31:2],2'b0};
assign fetch_instr_o       = skid_valid_q ? skid_buffer_q[31:0]  : icache_inst_i;
assign fetch_fault_fetch_o = skid_valid_q ? skid_buffer_q[64] : icache_error_i;
assign fetch_fault_page_o  = skid_valid_q ? skid_buffer_q[65] : icache_page_fault_i;
endmodule