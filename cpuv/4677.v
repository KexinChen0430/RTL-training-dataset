module control #(
    parameter d_width = 32, 
    reg_ct = 32,            
    ra_width = $clog2(reg_ct), 
    op_width = 3            
)
(
    output reg[op_width-1:0] alu_op, 
    output reg shift_dir,            
    output reg select_alu,           
    input [op_width-1:0] opcode,     
    input clk                        
);
always @(posedge clk) begin
    alu_op <= opcode; 
    select_alu <= (opcode == op.SLL || opcode == op.SRL) ? 0 : 1;
    shift_dir <= opcode[0]; 
end
endmodule