module controller_unit_tb; 
	reg [7:0] opcode; 
	reg clk; 
	reg res; 
	wire [1:0] ac_source; 
	wire write_ac; 
	wire mar_source; 
	wire write_mar; 
	wire [1:0] mdr_source; 
	wire write_mdr; 
	wire write_flags; 
	wire [1:0] pc_source; 
	wire write_pc; 
	wire write_ir; 
	wire write_mem; 
	wire [2:0] ALU_op_select; 
	wire [2:0] ALUctl; 
	controller_unit uut ( 
			.opcode(opcode), 
			.clk(clk), 
			.res(res), 
			.ac_source(ac_source), 
			.write_ac(write_ac), 
			.mar_source(mar_source), 
			.write_mar(write_mar), 
			.mdr_source(mdr_source), 
			.write_mdr(write_mdr), 
			.write_flags(write_flags), 
			.pc_source(pc_source), 
			.write_pc(write_pc), 
			.write_ir(write_ir), 
			.write_mem(write_mem), 
			.ALU_op_select(ALU_op_select), 
			.ALUctl(ALUctl) 
		);
	initial begin 
		opcode = 8'h03; 
		clk = 0; 
		res = 1; 
		$dumpfile("controller_unit.vcd"); 
		$dumpvars; 
		#100	res = 0; 
		#1000	$finish; 
	end
	always
		#50		clk = ~clk; 
endmodule 