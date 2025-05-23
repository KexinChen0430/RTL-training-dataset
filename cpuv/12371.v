module riscv_divider
(
     input           clk_i, 
     input           rst_i, 
     input           opcode_valid_i, 
     input           inst_div_w, 
     input           inst_divu_w, 
     input           inst_rem_w, 
     input           inst_remu_w, 
     input  [ 31:0]  opcode_ra_operand_i, 
     input  [ 31:0]  opcode_rb_operand_i, 
     output          writeback_valid_o, 
     output [ 31:0]  writeback_value_o 
);
reg          valid_q; 
reg  [31:0]  wb_result_q; 
wire div_rem_inst_w     = (inst_div_w)  || 
                          (inst_divu_w) ||
                          (inst_rem_w)  ||
                          (inst_remu_w);
wire signed_operation_w = (inst_div_w) || (inst_rem_w); 
wire div_operation_w    = (inst_div_w) || (inst_divu_w); 
reg [31:0] dividend_q; 
reg [62:0] divisor_q; 
reg [31:0] quotient_q; 
reg [31:0] q_mask_q; 
reg        div_inst_q; 
reg        div_busy_q; 
reg        invert_res_q; 
wire div_start_w    = opcode_valid_i & div_rem_inst_w; 
wire div_complete_w = !(|q_mask_q) & div_busy_q; 
always @(posedge clk_i)
if (rst_i)
begin
    div_busy_q     <= 1'b0; 
    dividend_q     <= 32'b0; 
    divisor_q      <= 63'b0; 
    invert_res_q   <= 1'b0; 
    quotient_q     <= 32'b0; 
    q_mask_q       <= 32'b0; 
    div_inst_q     <= 1'b0; 
end
else if (div_start_w)
begin
    div_busy_q     <= 1'b1; 
    div_inst_q     <= div_operation_w; 
    if (signed_operation_w && opcode_ra_operand_i[31])
        dividend_q <= -opcode_ra_operand_i; 
    else
        dividend_q <= opcode_ra_operand_i; 
    if (signed_operation_w && opcode_rb_operand_i[31])
        divisor_q <= {-opcode_rb_operand_i, 31'b0}; 
    else
        divisor_q <= {opcode_rb_operand_i, 31'b0}; 
    invert_res_q  <= ((inst_div_w) && (opcode_ra_operand_i[31] != opcode_rb_operand_i[31]) && |opcode_rb_operand_i) ||
                     ((inst_rem_w) && opcode_ra_operand_i[31]); 
    quotient_q     <= 32'b0; 
    q_mask_q       <= 32'h80000000; 
end
else if (div_complete_w)
begin
    div_busy_q <= 1'b0; 
end
else if (div_busy_q)
begin
    if (divisor_q <= {31'b0, dividend_q})
    begin
        dividend_q <= dividend_q - divisor_q[31:0]; 
        quotient_q <= quotient_q | q_mask_q; 
    end
    divisor_q <= {1'b0, divisor_q[62:1]}; 
    q_mask_q  <= {1'b0, q_mask_q[31:1]}; 
end
reg [31:0] div_result_r; 
always @ *
begin
    div_result_r = 32'b0; 
    if (div_inst_q)
        div_result_r = invert_res_q ? -quotient_q : quotient_q; 
    else
        div_result_r = invert_res_q ? -dividend_q : dividend_q; 
end
always @(posedge clk_i)
if (rst_i)
    valid_q <= 1'b0; 
else
    valid_q <= div_complete_w; 
always @(posedge clk_i)
if (rst_i)
    wb_result_q <= 32'b0; 
else if (div_complete_w)
    wb_result_q <= div_result_r; 
assign writeback_valid_o = valid_q; 
assign writeback_value_o  = wb_result_q; 
endmodule