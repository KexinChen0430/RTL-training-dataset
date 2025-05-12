module nkmd_cpu_ex(
    input wire clk,
    input wire rst,
    input wire [31:0] rsval_i,
    input wire [31:0] rtval_i,
    input wire [`DCD_ALUSEL_W-1:0] alusel_i,
    input wire [`DCD_REGSEL_W-1:0] rdsel_i,
    input wire jmp_en_i,
    input wire [31:0] rdval_i,
    input wire [`DCD_MWSEL_W-1:0] mwsel_i,
    input wire [`DCD_JMPREL_W-1:0] jmprel_i,
    output wire [`DCD_REGSEL_W-1:0] rdsel_o,
    output wire [31:0] val_o,
    output wire [31:0] rdval_o,
    output wire [`DCD_MWSEL_W-1:0] mwsel_o,
    output wire jmp_en_o,
    output wire [31:0] jmp_pc_o);
reg [31:0] val_ff;
assign val_o = val_ff;
always @(posedge clk) begin
    if (rst) begin
        val_ff <= 32'h0;
    end else begin
        case (alusel_i)
        `OP_ADD:
            val_ff <= rsval_i + rtval_i;
        `OP_SUB:
            val_ff <= rsval_i - rtval_i;
        `OP_OR:
            val_ff <= rsval_i | rtval_i;
        `OP_AND:
            val_ff <= rsval_i & rtval_i;
        `OP_XOR:
            val_ff <= rsval_i ^ rtval_i;
        `OP_RESERVED, `OP_CLAMP, `OP_MUL:
            val_ff <= 32'h0;
        endcase
    end
end
reg [`DCD_REGSEL_W-1:0] rdsel_ff;
reg [31:0] rdval_ff;
reg [`DCD_MWSEL_W-1:0] mwsel_ff;
always @(posedge clk) begin
    if (rst) begin
        rdsel_ff <= 0;
        rdval_ff <= 0;
        mwsel_ff <= 0;
    end else begin
        rdsel_ff <= rdsel_i;
        rdval_ff <= rdval_i;
        mwsel_ff <= mwsel_i;
    end
end
assign rdsel_o = rdsel_ff;
assign rdval_o = rdval_ff;
assign mwsel_o = mwsel_ff;
reg jmp_en_ff;
reg [31:0] jmp_pc_ff;
always @(posedge clk) begin
    if (rst) begin
        jmp_en_ff <= 0;
        jmp_pc_ff <= 0;
    end else begin
        jmp_en_ff <= jmp_en_i;
        jmp_pc_ff <= rdval_i + jmprel_i; 
    end
end
assign jmp_en_o = jmp_en_ff;
assign jmp_pc_o = jmp_pc_ff;
endmodule