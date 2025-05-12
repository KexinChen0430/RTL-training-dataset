module decoder
(
    input [31:0] instruction,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sham,
    output [5:0] funct,
    output [15:0] imm16,
    output [25:0] imm26
);
`include "defines.vh"
    assign op    = instruction[`OP];
    assign rs    = instruction[`RS];
    assign rt    = instruction[`RT];
    assign rd    = instruction[`RD];
    assign sham  = instruction[`SHAM];
    assign funct = instruction[`FUNCT];
    assign imm16 = instruction[`IMM16];
    assign imm26 = instruction[`IMM26];
endmodule