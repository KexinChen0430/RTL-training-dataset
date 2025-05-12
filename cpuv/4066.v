module pipeline_tb;
	reg clk; 
	reg reset; 
	reg ena; 
	integer ciclo; 
	wire [31:0] test_pc_incrementado_PC; 
	wire [31:0] test_instruction_IF; 
	pipeline uut (
		.clk(clk),
		.reset(reset),
		.ena(ena),
		.test_pc_incrementado_PC(test_pc_incrementado_PC),
		.test_instruction_IF(test_instruction_IF)
	);
	initial begin
		clk = 0; 
		reset = 1; 
		ciclo = 0; 
		ena = 1'b0; 
		#2;
		begin
			reset = 1'b0; 
		end
		#1000
		ena = 1'b1; 
	end
	always
		begin
			#1
			clk = ~clk; 
			#1
			clk = ~clk; 
			ciclo = ciclo + 1; 
		end
endmodule