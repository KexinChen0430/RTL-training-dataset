module ControlUnit (output reg IR_CU, RFLOAD, PCLOAD, SRLOAD, SRENABLED, ALUSTORE, MFA, WORD_BYTE,READ_WRITE,IRLOAD,MBRLOAD,MBRSTORE,MARLOAD,output reg[4:0] opcode, output reg[3:0] CU,  input MFC, Reset,Clk, input [31:0] IR,input [3:0] SR);
reg [4:0] State, NextState;
task registerTask;
input [17:0] signals;
fork
	#2 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = {signals[17],1'b0,signals[15],1'b0,signals[13],1'b0,signals[11:9],1'b0,1'b0,1'b0,signals[5:0]};
	#4 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = signals;
	#6 {CU,IR_CU, RFLOAD, PCLOAD, SRLOAD,opcode, SRENABLED, ALUSTORE, MARLOAD,MBRSTORE,MBRLOAD,IRLOAD,MFA,READ_WRITE, WORD_BYTE} = signals;
join
endtask
always @ (negedge Clk, posedge Reset)
	if (Reset) begin
		State <= 5'b00001; IR_CU= 0 ; RFLOAD= 0 ; PCLOAD= 0 ; SRLOAD= 0 ; SRENABLED= 0 ; MFA= 0 ; WORD_BYTE= 0 ;READ_WRITE= 0 ;IRLOAD= 0 ;MBRLOAD= 0 ;MBRSTORE= 0 ;MARLOAD = 0 ;CU=0;end
	else
		State <= NextState;
always @ (State, MFC)
	case (State)
		5'b00000 : NextState = 5'b00000;
always @ (State, MFC)
	case (State)
		5'b00000 : begin  opcode = 0; ALUSTORE = 1 ; end
endmodule