module decode(inst,
	opndC, opndA, opndB,
	arithmetic, slowArithmetic, logic, memory,
	reg_bank_control, control,  arith_cntl,
	control_mask
);
	input [15:0] inst;
	output [3:0] opndC, opndA, opndB;
	output [4:0] reg_bank_control;
	output [2:0] control;      
	output [2:0] arith_cntl;
	output reg arithmetic;     
	output reg slowArithmetic; 
	output reg logic;          
	output reg memory;         
	output [2:0] control_mask;
	assign opndC = inst[11:08];
	assign opndA = inst[07:04];
	assign opndB = inst[03:00];
	wire top_op = (inst[14:12] != 3'b000);
	wire bot_op = (inst[03:01] != 3'b000); 
	assign reg_bank_control[4] = (inst[14:13] == 2'b01);
	assign reg_bank_control[3] = (inst[14:12] == 3'b001);
	assign reg_bank_control[2] = (~top_op & (inst[3:1] == 3'b100));
	assign reg_bank_control[1] = (~top_op & (inst[3:0] == 4'b1110));
	assign reg_bank_control[0] = top_op | bot_op;
	assign control = inst[2:0];
	assign arith_cntl = (top_op) ? inst[14:12] : {2'b11, inst[0]};
	wire [3:0] cmd_top = inst[14:12];
	wire [3:0] cmd_bot = inst[3:1];
	always @ (*) begin
		if(top_op) begin
			loadHex = (cmd_top[2:0] == 3'b001);
			arithmetic = (cmd_top[2] ^ cmd_top[1]);
			slowArithmetic = 1'b0;
			logic = 1'b0;
			memory = (cmd_top[2:1] == 2'b11);
			move = 1'b0;
		end else if(bot_op) begin
			loadHex = 1'b0;
			arithmetic = (cmd_bot[2:0] == 3'b001);
			slowArithmetic = (cmd_bot[2:1] == 3'b01);
			logic = ((cmd_bot[2] == 1'b1) & ~move); 
			memory = 1'b0;s
			move = (cmd_bot[1:0] == 2'b00);
		end else begin
			loadHex = 1'b0;
			arithmetic = 1'b0;
			slowArithmetic = 1'b0;
			logic = 1'b0;
			memory = 1'b0;
			move = 1'b0;
		end
	end
	assign control_mask = {logic, logic&slowArithmetic&memory, logic&slowArithmetic&move};
endmodule