module ram(input [11:0] adr, input we, inout [31:0] data); 
reg [31:0]ram[11:0]; 
integer i = 0; 
parameter  NOP        = 4'b0000; 
parameter  LOAD       = 4'b0001; 
parameter  STORE      = 4'b0010; 
parameter  BRANCH     = 4'b0011; 
parameter  XOR        = 4'b0100; 
parameter  ADD        = 4'b0101; 
parameter  ROTATE     = 4'b0110; 
parameter  SHIFT      = 4'b0111; 
parameter  HALT       = 4'b1000; 
parameter  COMPLEMENT = 4'b1001; 
parameter ALWAYS   = 4'b0000; 
parameter PARITY   = 4'b0001; 
parameter EVEN     = 4'b0010; 
parameter CARRY    = 4'b0011; 
parameter NEGATIVE = 4'b0100; 
parameter ZERO     = 4'b0101; 
parameter NOCARRY  = 4'b0110; 
parameter POSITIVE = 4'b0111; 
parameter reg0 = 12'b000000000_000; 
parameter reg1 = 12'b000000000_001; 
parameter reg2 = 12'b000000000_010; 
parameter reg3 = 12'b000000000_011; 
parameter reg4 = 12'b000000000_100; 
parameter reg5 = 12'b000000000_101; 
parameter reg6 = 12'b000000000_110; 
parameter reg7 = 12'b000000000_111; 
parameter mem0 = 12'b000001_111111; 
parameter mem1 = 12'b000010_111111; 
parameter mem2 = 12'b000011_111111; 
parameter mem3 = 12'b000100_111111; 
parameter mem4 = 12'b000101_111111; 
parameter mem5 = 12'b000110_111111; 
parameter mem6 = 12'b000111_111111; 
parameter mem7 = 12'b001000_111111; 
parameter is0 = 12'b000000_000000; 
parameter is1 = 12'b000000_000001; 
parameter is2 = 12'b000000_000010; 
parameter is3 = 12'b000000_000011; 
parameter is4 = 12'b000000_000100; 
parameter is5 = 12'b000000_000101; 
parameter is6 = 12'b000000_000110; 
parameter is7 = 12'b000000_000111; 
parameter is8 = 12'b000000_001000; 
parameter is9 = 12'b000000_001001; 
parameter REG = 1'b0; 
parameter MEM = 1'b0; 
parameter IMM = 1'b1; 
parameter xx = 2'b00; 
parameter addressx = 12'b000000_000000; 
parameter imm0 = 12'b000000_000000; 
parameter imm1 = 12'b000000_000001; 
assign data = (we) ? 'bz : ram[adr]; 
initial begin
	for(i = 0; i< 12; i = i +1) begin
		ram[i] = 'd0; 
	end
	ram[is0] = {reg0,mem0,xx,REG,MEM,LOAD}; 
	ram[is1] = {addressx,is5,ZERO,BRANCH}; 
	ram[is2] = {reg0,imm1,xx,REG,IMM,SHIFT}; 
	ram[is3] = {reg1,imm1,xx,REG,IMM,ADD}; 
	ram[is4] = {addressx,is1,ALWAYS,BRANCH}; 
	ram[is5] = {mem1,reg1,xx,MEM,REG,STORE}; 
	ram[is6] = {addressx,addressx,xx,xx,HALT}; 
	ram[mem0] = 'b11010100_00001101_11011111_11001100; 
end
always@(adr or we) begin
	if(we) begin
		ram[adr] = data; 
	end
end
endmodule 