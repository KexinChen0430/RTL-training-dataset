module decode (
	input [31:0] inst, 
	output [4:0] rs1, 
	output [4:0] rs2, 
	output [4:0] wd, 
	output reg [2:0] wb_sel, 
	output rf_wr_en, 
	output memory_request, 
	output memory_request_type, 
	output reg pcr_enable, 
	output reg [1:0] pcr_cmd 
);
	wire [6:0] opcode = inst[6:0];
	assign rs1 = inst[26:22];
	assign rs2 = inst[21:17];
	assign wd = (opcode == `OPCODE_JAL) ? 5'd1 : inst[31:27];
	assign rf_wr_en = (opcode == `OPCODE_OP ||
	                   opcode == `OPCODE_OP_IMM ||
	                   opcode == `OPCODE_LUI ||
	                   opcode == `OPCODE_LOAD ||
	                   opcode == `OPCODE_JAL ||
	                   opcode == `OPCODE_JALR ||
			   opcode == `OPCODE_PCR);
	assign memory_request = (opcode == `OPCODE_LOAD ||
	                         opcode == `OPCODE_STORE);
	assign memory_request_type = (opcode == `OPCODE_STORE) ?
	                             `MEM_REQ_WRITE : `MEM_REQ_READ;
	always @ (*) begin
		case (opcode)
			`OPCODE_OP, `OPCODE_OP_IMM, `OPCODE_LUI:
				wb_sel = `WB_ALU;
			`OPCODE_LOAD:
				wb_sel = `WB_MEM;
			`OPCODE_JAL, `OPCODE_JALR:
				wb_sel = `WB_PC4;
			`OPCODE_PCR:
				wb_sel = `WB_PCR;
			default:
				wb_sel = 0;
		endcase
	end
	always @ (*) begin
		if (opcode == `OPCODE_PCR) begin
			pcr_enable = 1;
			pcr_cmd = inst[8:7];
		end else begin
			pcr_enable = 0;
			pcr_cmd = 2'b00;
		end
	end
endmodule