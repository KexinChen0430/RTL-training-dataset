module riscv_alu
(
    input  [3:0]  alu_op_i,      
    input  [31:0] alu_a_i,       
    input  [31:0] alu_b_i,       
    output [31:0] alu_p_o        
);
`include "riscv_defs.v"
reg [31:0] result_r;
reg [31:16] shift_right_fill_r; 
reg [31:0] shift_right_1_r;     
reg [31:0] shift_right_2_r;     
reg [31:0] shift_right_4_r;     
reg [31:0] shift_right_8_r;     
reg [31:0] shift_left_1_r;      
reg [31:0] shift_left_2_r;      
reg [31:0] shift_left_4_r;      
reg [31:0] shift_left_8_r;      
wire [31:0] sub_res_w = alu_a_i - alu_b_i;
always @ (alu_op_i or alu_a_i or alu_b_i or sub_res_w)
begin
    shift_right_fill_r = 16'b0;
    shift_right_1_r = 32'b0;
    shift_right_2_r = 32'b0;
    shift_right_4_r = 32'b0;
    shift_right_8_r = 32'b0;
    shift_left_1_r = 32'b0;
    shift_left_2_r = 32'b0;
    shift_left_4_r = 32'b0;
    shift_left_8_r = 32'b0;
    case (alu_op_i)
       `ALU_SHIFTL :
       begin
       end
       `ALU_SHIFTR, `ALU_SHIFTR_ARITH:
       begin
       end
       `ALU_ADD :
       begin
       end
       `ALU_SUB :
       begin
       end
       `ALU_AND :
       begin
       end
       `ALU_OR  :
       begin
       end
       `ALU_XOR :
       begin
       end
       `ALU_LESS_THAN :
       begin
       end
       `ALU_LESS_THAN_SIGNED :
       begin
       end
       default  :
       begin
            result_r = alu_a_i;
       end
    endcase
end
assign alu_p_o = result_r;
endmodule