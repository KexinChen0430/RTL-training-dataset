module control(
    input  wire	[5:0]	opcode, 
    output wire 		regdst, 
    output wire 		memread, 
    output wire 		memtoreg, 
    output wire [1:0]	branch, 
    output wire [1:0]	aluop, 
    output wire			memwrite, 
    output wire			alusrc, 
    output wire			regwrite); 
reg oc_lw, oc_addi, oc_beq, oc_sw, oc_bne, oc_add; 
always @(*) begin
    oc_lw   <= 1'b0; 
    oc_addi <= 1'b0; 
    oc_beq  <= 1'b0; 
    oc_sw   <= 1'b0; 
    oc_bne  <= 1'b0; 
    oc_add  <= 1'b0; 
    case (opcode) 
        6'b100011: oc_lw   <= 1'b1;	
        6'b001000: oc_addi <= 1'b1;	
        6'b000100: oc_beq  <= 1'b1;	
        6'b101011: oc_sw   <= 1'b1;	
        6'b000101: oc_bne  <= 1'b1;	
        6'b000000: oc_add  <= 1'b1;	
    endcase
end
assign regdst = ~(oc_lw | oc_addi); 
assign branch[`BRANCH_BEQ] = oc_beq; 
assign branch[`BRANCH_BNE] = oc_bne; 
assign memread = oc_lw; 
assign memtoreg = oc_lw; 
assign aluop[0] = oc_beq | oc_bne; 
assign aluop[1] = ~(oc_lw | oc_addi | oc_beq | oc_sw | oc_bne); 
assign memwrite = oc_sw; 
assign alusrc = oc_lw | oc_addi | oc_sw; 
assign regwrite = ~(oc_beq | oc_sw | oc_bne); 
endmodule