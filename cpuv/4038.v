module instr_mem (
    input [31:0] address,       
    output [31:0] instruction   
);
    reg [31:0] memory [249:0];
    integer i;
    initial begin
        for (i = 0; i < 250; i = i + 1) memory[i] = 32'b0;
        memory[10] = 32'b001000_00000_01000_0000000000000010; 
        memory[11] = 32'b001000_00000_01001_0000000000000010; 
        memory[12] = 32'b001000_00000_01011_0000000000000010; 
        memory[13] = 32'b000011_00000000000000000000001000;   
    end
    assign instruction = memory[address >> 2];
endmodule