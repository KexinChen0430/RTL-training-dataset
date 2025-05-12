module scheduler2_allocate_rsv_station #(
    parameter P_ALU2_PRIORITY_LEVEL = 4'h0
)(
    input wire iORDER_LOCK,                  
    input wire iORDER_0_VALID,               
    input wire iORDER_0_EX_SYS_REG,          
    input wire iORDER_0_EX_SYS_LDST,         
    input wire iORDER_0_EX_LOGIC,            
    input wire iORDER_0_EX_SHIFT,            
    input wire iORDER_0_EX_ADDER,            
    input wire iORDER_0_EX_MUL,              
    input wire iORDER_0_EX_SDIV,             
    input wire iORDER_0_EX_UDIV,             
    input wire iORDER_0_EX_LDST,             
    input wire iORDER_0_EX_BRANCH,           
    input wire iORDER_1_VALID,
    input wire iORDER_1_EX_SYS_REG,
    input wire iORDER_1_EX_SYS_LDST,
    input wire iORDER_1_EX_LOGIC,
    input wire iORDER_1_EX_SHIFT,
    input wire iORDER_1_EX_ADDER,
    input wire iORDER_1_EX_MUL,
    input wire iORDER_1_EX_SDIV,
    input wire iORDER_1_EX_UDIV,
    input wire iORDER_1_EX_LDST,
    input wire iORDER_1_EX_BRANCH,
    input wire [3:0] iRS1_COUNT,             
    input wire [3:0] iRS2_COUNT,             
    output wire oRS0_0_VALID,                
    output wire oRS1_0_VALID,                
    output wire oRS2_0_VALID,                
    output wire oRS3_0_VALID,                
    output wire oRS0_1_VALID,                
    output wire oRS1_1_VALID,                
    output wire oRS2_1_VALID,                
    output wire oRS3_1_VALID                 
);
wire rs1_0_select;
wire rs1_1_select;
wire rs2_0_select;
wire rs2_1_select;
localparam PL_ALU_SEL_ALU1 = 1'h0;          
localparam PL_ALU_SEL_ALU2 = 1'h1;          
function [1:0] func_alu_select;
    input [3:0] func_alu1_cnt;               
    input [3:0] func_alu2_cnt;               
    input func_valid;                        
    input func_ex_mul;                       
    input func_ex_sdiv;                      
    input func_ex_udiv;                      
    input func_ex_logic;                     
    input func_ex_shift;                     
    input func_ex_adder;                     
    input func_ex_sys_reg;                   
    begin
    end
endfunction
wire pipe0_alu_valid;
wire pipe0_alu_valid_number;
wire pipe1_alu_valid;
wire pipe1_alu_valid_number;
assign {pipe0_alu_valid, pipe0_alu_valid_number} = func_alu_select(
);
assign {pipe1_alu_valid, pipe1_alu_valid_number} = func_alu_select(
);
assign oRS0_0_VALID = !iORDER_LOCK && iORDER_0_VALID && iORDER_0_EX_BRANCH;
assign oRS0_1_VALID = !iORDER_LOCK && iORDER_1_VALID && iORDER_1_EX_BRANCH;
assign oRS1_0_VALID = pipe0_alu_valid && (pipe0_alu_valid_number == PL_ALU_SEL_ALU1);
assign oRS1_1_VALID = pipe1_alu_valid && (pipe1_alu_valid_number == PL_ALU_SEL_ALU1);
assign oRS2_0_VALID = pipe0_alu_valid && (pipe0_alu_valid_number == PL_ALU_SEL_ALU2);
assign oRS2_1_VALID = pipe1_alu_valid && (pipe1_alu_valid_number == PL_ALU_SEL_ALU2);
assign oRS3_0_VALID = !iORDER_LOCK && iORDER_0_VALID && (iORDER_0_EX_LDST || iORDER_0_EX_SYS_LDST);
assign oRS3_1_VALID = !iORDER_LOCK && iORDER_1_VALID && (iORDER_1_EX_LDST || iORDER_1_EX_SYS_LDST);
endmodule