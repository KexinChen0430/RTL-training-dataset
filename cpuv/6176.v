module spoof(
	instruction_opcode,
	ex_freeze,
	clk_in,
	data_out,
	reset,
	debug_out
	);
input	[31:0]	instruction_opcode;
input		ex_freeze;
input		clk_in;
input		reset;
output		data_out;
output		debug_out;
localparam	STATE_Initial		= 3'd0,
		STATE_1			= 3'd1,
		STATE_2			= 3'd2,
		STATE_3			= 3'd3,
		STATE_4			= 3'd4,
		STATE_5_Placeholder	= 3'd5,
		STATE_6_Placeholder	= 3'd6,
		STATE_7_Placeholder	= 3'd7;
localparam	OPCODE_A		= 32'h15000000,
		OPCODE_B		= 32'h15000000,
		OPCODE_C		= 32'h15000000,
		OPCODE_D		= 32'h15000000;
wire [31:0] instruction_opcode;
wire ex_freeze;
wire clk_in;
wire reset;
reg  data_out;
reg[2:0] CurrentState;
reg[2:0] NextState;
reg[31:0] FirstOp;
reg[31:0] FirstOp_Next;
reg[31:0] SecondOp;
reg[31:0] SecondOp_Next;
reg[31:0] ThirdOp;
reg[31:0] ThirdOp_Next;
reg[31:0] CurrentOp;
reg[31:0] debug_out;
always@ (posedge clk_in)
begin: STATE_TRANS
	if(reset)
		begin
		CurrentState <= STATE_Initial;
		FirstOp <= 32'h00000000;
		SecondOp <= 32'h00000000;
		ThirdOp <= 32'h00000000;
		end
	else
		begin
		CurrentState <= NextState;
		FirstOp <= FirstOp_Next;
		SecondOp <= SecondOp_Next;
		ThirdOp <= ThirdOp_Next;
		end
end
always@ (*)
begin
	if(ex_freeze) begin
		NextState <= CurrentState;
		FirstOp_Next <= FirstOp;
		SecondOp_Next <= SecondOp;
		ThirdOp_Next <= ThirdOp;
	end
	else begin
		FirstOp_Next <=	SecondOp;
		SecondOp_Next <= ThirdOp;
		ThirdOp_Next <= instruction_opcode;
		case(CurrentState)
			STATE_Initial: begin
				NextState <= STATE_1;
			end
			STATE_1: begin
				NextState <= STATE_2;
			end
			STATE_2: begin
				NextState <= STATE_3;
			end
			STATE_3: begin
				if(instruction_opcode == OPCODE_D && FirstOp == OPCODE_A && SecondOp == OPCODE_B && ThirdOp == OPCODE_C) NextState <= STATE_4;
				else NextState <= STATE_3;
			end
			STATE_4: begin
				NextState <= STATE_3;
			end
			STATE_5_Placeholder: begin
			end
			STATE_6_Placeholder: begin
			end
			STATE_7_Placeholder: begin
			end
		endcase
	end
end
always@ (*)
begin
	data_out = 1'b0;
	debug_out <= FirstOp;
	if(CurrentState == STATE_4) data_out = 1'b1;
end
endmodule