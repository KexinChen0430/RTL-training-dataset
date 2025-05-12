module ControlUnit (
    output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE, READ_WRITE, IRLOAD, MBRLOAD, MBRSTORE, MARLOAD,
    output reg [4:0] opcode,
    output reg [3:0] CU,
    input MFC, Reset, Clk,
    input [31:0] IR,
    input [3:0] SR
);
reg [4:0] State, NextState;
task registerTask;
    input [17:0] signals; 
    fork
        #2 {CU, IR_CU, RFLOAD, PCLOAD, SRLOAD, opcode, SRENABLED, ALUSTORE, MARLOAD, MBRSTORE, MBRLOAD, IRLOAD, MFA, READ_WRITE, WORD_BYTE} = {signals[17], 1'b0, signals[15], 1'b0, signals[13], 1'b0, signals[11:9], 1'b0, 1'b0, 1'b0, signals[5:0]};
        #4 {CU, IR_CU, RFLOAD, PCLOAD, SRLOAD, opcode, SRENABLED, ALUSTORE, MARLOAD, MBRSTORE, MBRLOAD, IRLOAD, MFA, READ_WRITE, WORD_BYTE} = signals;
        #6 {CU, IR_CU, RFLOAD, PCLOAD, SRLOAD, opcode, SRENABLED, ALUSTORE, MARLOAD, MBRSTORE, MBRLOAD, IRLOAD, MFA, READ_WRITE, WORD_BYTE} = signals;
    join
endtask
always @ (negedge Clk, posedge Reset)
    if (Reset) begin
        State <= 5'b00000; 
    end else begin
        State <= NextState; 
    end
always @ (State, MFC)
    case (State)
        5'b00000 : if (Reset) NextState = 5'b00000; else NextState = 5'b00001;
        5'b00001 : NextState = 5'b00010;
        5'b10001 : NextState = 5'b00000; 
        default : begin end 
    endcase
always @ (State, MFC)
    case (State)
        5'b00000 : begin opcode = 0; ALUSTORE = 1; end
        5'b00001 : begin opcode = 1; ALUSTORE = 1; end 
        default : begin end 
    endcase
endmodule