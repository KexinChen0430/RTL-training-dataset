module raycast_core_axis_dp
(
    clk, rst, init_i, push_i, pop_i, tem_latch_i,
    idx_i, idx_prev_i,
    te0_i, te1_i,
    te0_o, tem_o, te1_o, te1_child_o
);
parameter dw = 32; 
parameter stack_size = 10; 
input clk; 
input rst; 
input init_i; 
input push_i; 
input pop_i; 
input tem_latch_i; 
input idx_i; 
input idx_prev_i; 
input signed [dw-1:0] te0_i; 
input signed [dw-1:0] te1_i; 
output signed [dw-1:0] te0_o; 
output signed [dw-1:0] tem_o; 
output signed [dw-1:0] te1_o; 
output signed [dw-1:0] te1_child_o; 
reg signed [dw-1:0] te0; 
reg signed [dw-1:0] te1; 
reg signed [dw-1:0] tem; 
`ifndef RAYC_DISABLE_STACK
reg [stack_size:0] te_bit_stack; 
`endif
wire signed [dw:0]  tem2; 
wire signed [dw-1:0] te0_child; 
wire signed [dw-1:0] te1_child; 
`ifndef RAYC_DISABLE_STACK
wire te_bit_next; 
wire signed [dw:0] te_recover; 
wire signed [dw-1:0] tem_prev; 
wire signed [dw-1:0] te_pass; 
wire signed [dw-1:0] te0_prev; 
wire signed [dw-1:0] te1_prev; 
`endif
assign te0_o = te0; 
assign tem_o = tem; 
assign te1_o = te1; 
assign te1_child_o = te1_child; 
assign tem2 = te0+te1; 
assign te0_child = idx_i ? tem : te0; 
assign te1_child = idx_i ? te1 : tem; 
`ifndef RAYC_DISABLE_STACK
assign te_bit_next = tem2[0]; 
assign te0_prev = idx_prev_i ? te_recover[dw-1:0] : te0; 
assign te1_prev = idx_prev_i ? te1 : te_recover[dw-1:0]; 
assign tem_prev = idx_prev_i ? te0: te1; 
assign te_pass = idx_prev_i ? te1 : te0; 
assign te_recover = {tem_prev, te_bit_stack[0]} - {te_pass[dw-1], te_pass}; 
`endif
always @(posedge clk)
begin
    if (tem_latch_i) begin
        tem <= (tem2)>>>1; 
    end
end
integer i; 
always @(posedge clk)
    if (init_i) begin
        te0 <= te0_i; 
        te1 <= te1_i; 
    end
    else if (push_i) begin
        te0 <= te0_child; 
        te1 <= te1_child; 
`ifndef RAYC_DISABLE_STACK
        te_bit_stack <= {te_bit_stack[stack_size-2:0], te_bit_next}; 
    end
    else if (pop_i) begin
        te_bit_stack <= {1'b0, te_bit_stack[stack_size-1:1]}; 
        te0 <= te0_prev; 
        te1 <= te1_prev; 
`endif
    end
endmodule