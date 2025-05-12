module instruction_decoder #(
    parameter REGISTER_ID_WIDTH = 4,    
    parameter LITERAL_WIDTH     = 16,   
    parameter OP_CODE_WIDTH     = 4,    
    parameter INSTRUCTION_WIDTH = OP_CODE_WIDTH + 2 * REGISTER_ID_WIDTH + LITERAL_WIDTH,
    parameter DATA_WIDTH        = 16,   
    parameter ALU_OP_WIDTH      = 3,    
    parameter INSTRUCTION_ADDRESS_WIDTH = 8
) (
    input clk_i,    
    input rst_i,    
    input [DATA_WIDTH-1:0] alu_status_i,    
    input [DATA_WIDTH-1:0] load_value_i,    
    input mem_rdy_i,                        
    output reg alu_active_o,                
    output reg [ALU_OP_WIDTH-1:0] alu_op_o, 
    output reg [REGISTER_ID_WIDTH-1:0] choose_reg1_o, 
    output reg [REGISTER_ID_WIDTH-1:0] choose_reg2_o, 
    output reg mem_active_o,                
    output reg register_active_o,           
    output reg [DATA_WIDTH-1:0] register_value_o, 
    output reg we_o,                        
    input [INSTRUCTION_WIDTH-1:0] instruction_feed, 
    output [INSTRUCTION_ADDRESS_WIDTH-1:0] iaddr_o  
);
parameter [OP_CODE_WIDTH-1:0]
    NOP     = 4'b0000, 
    SET     = 4'b0001, 
    LOAD    = 4'b0010, 
    STORE   = 4'b0011, 
    BRA     = 4'b0100, 
    BNE     = 4'b0101, 
    PLUS    = 4'b1000, 
    MINUS   = 4'b1001, 
    MUL     = 4'b1010, 
    DIV     = 4'b1011, 
    CMP     = 4'b1100, 
    END     = 4'b1111; 
reg [INSTRUCTION_ADDRESS_WIDTH-1:0] instruction_pointer; 
integer next_reg1; 
integer next_reg2; 
reg [OP_CODE_WIDTH-1:0] operation; 
reg [DATA_WIDTH:0] literal; 
reg [INSTRUCTION_ADDRESS_WIDTH-1:0] next_instruction; 
reg next_mem_active; 
reg next_we; 
reg next_alu_active; 
reg [DATA_WIDTH:0] next_register_value; 
reg next_register_active; 
always @* begin
    if (mem_active_o) begin
        if (mem_rdy_i) begin
            next_mem_active <= 0;
            next_instruction <= instruction_pointer + 1;
        end else begin
            next_mem_active <= 1;
            next_instruction <= instruction_pointer;
        end
        next_register_value <= 0;
        next_register_active <= 0;
        next_we <= we_o;
        next_alu_active <= 0;
    end else begin
        operation = instruction_feed[INSTRUCTION_WIDTH-1:INSTRUCTION_WIDTH-OP_CODE_WIDTH];
        next_reg1 = instruction_feed[INSTRUCTION_WIDTH-OP_CODE_WIDTH-1:INSTRUCTION_WIDTH-OP_CODE_WIDTH-REGISTER_ID_WIDTH];
        next_reg2 = instruction_feed[INSTRUCTION_WIDTH-OP_CODE_WIDTH-REGISTER_ID_WIDTH-1:INSTRUCTION_WIDTH-OP_CODE_WIDTH-2*REGISTER_ID_WIDTH];
        literal <= instruction_feed[LITERAL_WIDTH-1:0];
        next_alu_active <= (operation == PLUS || operation == MINUS || operation == MUL || operation == DIV);
        if (operation == BRA || (operation == BNE && !alu_status_i[alu.ZERO])) begin
            next_mem_active <= 0;
            next_instruction = literal;
        end else if (operation == LOAD || operation == STORE) begin
            next_mem_active <= 1;
            next_instruction = instruction_pointer;
        end else begin
            next_mem_active <= 0;
            next_instruction = instruction_pointer + 1;
        end
        next_we <= (operation == STORE);
        if (operation == SET) begin
            next_register_active <= 1;
            next_register_value <= literal;
        end else begin
            next_register_active <= 0;
        end
    end
end
always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        alu_active_o <= 0;
        alu_op_o <= 0;
        choose_reg1_o <= 0;
        choose_reg2_o <= 0;
        mem_active_o <= 0;
        we_o <= 0;
        instruction_pointer <= 0;
        register_value_o <= 0;
        register_active_o <= 0;
    end else begin
        choose_reg1_o <= next_reg1;
        choose_reg2_o <= next_reg2;
        register_value_o <= next_register_value;
        register_active_o <= next_register_active;
        alu_active_o <= next_alu_active;
        instruction_pointer <= next_instruction;
        mem_active_o <= next_mem_active;
        we_o <= next_we;
        alu_op_o <= operation[ALU_OP_WIDTH-1:0]; 
    end
end
endmodule