module third_step(
		input wire aluSrc,             
		input wire [5:0] ALUOp,        
		input wire regDst,             
		input wire [1:0] ForwardAE,    
		input wire [1:0] ForwardBE,    
		input wire [31:0] reg1,        
		input wire [31:0] reg2,        
		input wire [31:0] signExtend,  
		input wire [4:0] regDst1,      
		input wire [4:0] regDst2,      
		input wire [31:0] reg_muxes_b, 
		input wire [31:0] reg_muxes_d, 
		output wire [31:0] aluResult,  
		output wire [31:0] reg2Out,    
		output wire [4:0] muxRegDstOut 
    );
	mux #(5) muxRegDst (
		.select(regDst),
		.item_a(regDst1),
		.item_b(regDst2),
		.signal(muxRegDstOut)
	);
	wire [31:0] ALUoperator1; 
	mux4 mux_reg1 (
		.sel(ForwardAE),
		.item_a(reg1),
		.item_b(reg_muxes_b),
		.item_c(reg_muxes_d),
		.item_d(), 
		.signal(ALUoperator1)
	);
	wire [31:0] ALUoperator2; 
	mux4 mux_reg2 (
		.sel(ForwardBE),
		.item_a(reg2),
		.item_b(reg_muxes_b),
		.item_c(reg_muxes_d),
		.item_d(), 
		.signal(ALUoperator2)
	);
	wire [31:0] muxAluSrc2Out;
	mux muxAluSrc2 (
		.select(aluSrc),
		.item_a(ALUoperator2),
		.item_b(signExtend),
		.signal(muxAluSrc2Out)
	);
	wire [3:0] ALUcontrolOut;
	alu_control aluControl (
		.ALUOp(ALUOp), 
		.funct(signExtend[5:0]), 
		.ALUcontrolOut(ALUcontrolOut)
	);
	alu aluModule (
		.op1(ALUoperator1),
		.op2(muxAluSrc2Out),
		.alu_control(ALUcontrolOut),
		.result(aluResult),
		.zero() 
	);
	assign reg2Out = ALUoperator2;
endmodule