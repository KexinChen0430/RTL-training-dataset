module ALUControl (ALUCtrl, ALUop, FuncCode); 
	input [3:0] ALUop; 
	input [5:0] FuncCode; 
	output[3:0] ALUCtrl; 
	reg [3:0] ALUCtrl; 
always @ (ALUCtrl or ALUop or FuncCode) 
begin
if(ALUop==4'b1111) 
	begin
		case(FuncCode) 
		6'b100000 :ALUCtrl = `ADD; 
		6'b100010 :ALUCtrl = `SUB; 
		6'b100001 :ALUCtrl = `ADDU; 
		6'b100011 :ALUCtrl = `SUBU; 
		6'b000000 :ALUCtrl = `NOP; 
		6'b100100 :ALUCtrl = `AND; 
		6'b100101 :ALUCtrl = `OR; 
		6'b100110 :ALUCtrl = `XOR; 
		6'b000000 :ALUCtrl = `SLL; 
		6'b000011 :ALUCtrl = `SRA; 
		6'b000010 :ALUCtrl = `SRL; 
		6'b101010 :ALUCtrl = `SLT; 
		6'b101011 :ALUCtrl = `SLTU; 
		endcase 
	end
else ALUCtrl = ALUop; 
end 
endmodule 