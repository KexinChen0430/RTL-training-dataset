module SimpleCPU(clk, rst, cur_ins);
    parameter REG_SET_SIZE = 16; 
    parameter WORD_SIZE = 32;    
    parameter OP_NOP = 32'b00000000000000000000000000000000; 
    parameter OP_INC = 32'b00000000000000000000000000000001; 
    parameter OP_DEC = 32'b00000000000000000000000000000010; 
    input clk;                     
    input rst;                     
    input [WORD_SIZE-1:0] cur_ins; 
    reg [WORD_SIZE-1:0] regs [0:REG_SET_SIZE-1]; 
    reg [WORD_SIZE-1:0] CPSR;                    
    `define REG_SP regs[13] 
    `define REG_LR regs[14] 
    `define REG_PC regs[15] 
    `define CPSR_V CPSR[28] 
    `define CPSR_C CPSR[29] 
    `define CPSR_Z CPSR[30] 
    `define CPSR_N CPSR[31] 
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            $display("Resetting the CPU.");
            CPSR = 0;
            for (i = 0; i < REG_SET_SIZE; i = i + 1) begin
                regs[i] = 0;
            end
        end else begin 
            `REG_PC = `REG_PC + 1;
            $display("Current state:");
            $display("  r0:%8x r1:%8x  r2:%8x  r3:%8x  r4:%8x r5:%8x r6:%8x r7:%8x", regs[0], regs[1], regs[2], regs[3], regs[4], regs[5], regs[6], regs[7]);
            $display("  r8:%8x r9:%8x r10:%8x r11:%8x r12:%8x SP:%8x LR:%8x PC:%8x", regs[8], regs[9], regs[10], regs[11], regs[12], `REG_SP, `REG_LR, `REG_PC);
            $display("  cur_ins:%8x", cur_ins);
            case (cur_ins)
                OP_NOP: begin
                    $display("OP_NOP");
                end
                OP_INC: begin
                    $display("OP_INC");
                    regs[0] = regs[0] + 1;
                end
                OP_DEC: begin
                    $display("OP_DEC");
                    regs[0] = regs[0] - 1;
                end
                default: begin
                    $display("Unknown opcode %8x", cur_ins);
                end
            endcase
        end 
    end
endmodule