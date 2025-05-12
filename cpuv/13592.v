module ALU(
	operation_i,   
	status_i,      
	operand1_i,    
	operand2_i,    
	status_o,      
	result_o       
);
input wire [4:0] operation_i;   
input wire [7:0] status_i;      
input wire [15:0] operand1_i;   
input wire [15:0] operand2_i;   
output wire [7:0] status_o;     
output wire [15:0] result_o;    
reg [15:0] result_reg;          
reg cflag_reg;                  
reg vflag_reg;                  
assign result_o = result_reg;   
assign status_o[`N] = (operation_i == `ALU_ITF) ? operand1_i[`N] :
                      (operation_i == `ALU_BRK) ? status_i[`N] : result_reg[7];
assign status_o[`V] = (operation_i == `ALU_ITF) ? operand1_i[`V] :
                      (operation_i == `ALU_CLV) ? 1'h0 : vflag_reg;
assign status_o[`P] = (operation_i == `ALU_ITF) ? operand1_i[`P] : status_i[`P];
assign status_o[`B] = (operation_i == `ALU_ITF) ? operand1_i[`B] :
                      (operation_i == `ALU_BRK) ? 1'h1 : status_i[`B];
assign status_o[`D] = (operation_i == `ALU_ITF) ? operand1_i[`D] :
                      (operation_i == `ALU_CLD) ? 1'h0 :
                      (operation_i == `ALU_SED) ? 1'h1 : status_i[`D];
assign status_o[`I] = (operation_i == `ALU_ITF) ? operand1_i[`I] :
                      (operation_i == `ALU_CLI) ? 1'h0 :
                      (operation_i == `ALU_SEI) ? 1'h1 :
                      (operation_i == `ALU_BRK) ? 1'h1 : status_i[`I];
assign status_o[`Z] = (operation_i == `ALU_ITF) ? operand1_i[`Z] :
                      (operation_i == `ALU_BRK) ? status_i[`Z] :
                      (result_reg[7:0] == 8'h0) ? 1'h1 : 1'h0;
assign status_o[`C] = (operation_i == `ALU_ITF) ? operand1_i[`C] :
                      (operation_i == `ALU_CLC) ? 1'h0 :
                      (operation_i == `ALU_SEC) ? 1'h1 : cflag_reg;
always @(operand1_i or operand2_i or operation_i or status_i[`C])
begin
	case(operation_i)
		`ALU_ADD	:	begin 
							result_reg = operand1_i + operand2_i + status_i[`C];
							cflag_reg = result_reg[16]; 
							vflag_reg = (operand1_i[15] && operand2_i[15] && ~result_reg[15]) ||
										(~operand1_i[15] && ~operand2_i[15] && result_reg[15]);
						end
		`ALU_AND	:	begin 
							result_reg = operand1_i & operand2_i;
						end
		`ALU_BRK	:	begin 
							result_reg = operand1_i; 
						end
		`ALU_CMP	:	begin 
							result_reg = operand1_i - operand2_i;
							cflag_reg = operand1_i >= operand2_i ? 1'b1 : 1'b0; 
						end
		`ALU_DEC	:	begin 
							result_reg = operand1_i - 1;
						end
		`ALU_INC	:	begin 
							result_reg = operand1_i + 1;
						end
		`ALU_ITO	:	begin 
							result_reg = operand1_i; 
						end
		`ALU_ORA	:	begin 
							result_reg = operand1_i | operand2_i;
						end
		`ALU_ROL	:	begin 
							result_reg = (operand1_i << 1) | status_i[`C];
							cflag_reg = operand1_i[15]; 
						end
		`ALU_ROR	:	begin 
							result_reg = (operand1_i >> 1) | (status_i[`C] << 15);
							cflag_reg = operand1_i[0]; 
						end
		`ALU_SHL	:	begin 
							result_reg = operand1_i << 1;
							cflag_reg = operand1_i[15]; 
						end
		`ALU_SHR	:	begin 
							result_reg = operand1_i >> 1;
							cflag_reg = operand1_i[0]; 
						end
		`ALU_SUB	:	begin 
							result_reg = operand1_i - operand2_i - status_i[`C];
							cflag_reg = operand1_i >= (operand2_i + status_i[`C]) ? 1'b1 : 1'b0; 
							vflag_reg = (operand1_i[15] && ~operand2_i[15] && ~result_reg[15]) ||
										(~operand1_i[15] && operand2_i[15] && result_reg[15]);
						end
		`ALU_XOR	:	begin 
							result_reg = operand1_i ^ operand2_i;
						end
		default		:	begin 
							result_reg = result_reg; 
							cflag_reg = (operation_i == `ALU_CLC) ? 1'b0 :
										(operation_i == `ALU_SEC) ? 1'b1 : status_i[`C];
							vflag_reg = (operation_i == `ALU_CLV) ? 1'b0 : status_i[`V];
						end
	endcase
end
endmodule