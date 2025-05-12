module Control(
    input [3:0] opcode, 
    output  [2:0]ALUControl, 
    output RegWrite, 
    RegDst, 
    ALUSrc, 
    Branch, 
    MemWrite, 
    MemtoReg 
    );