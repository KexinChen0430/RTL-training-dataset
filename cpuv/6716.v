module Preshift (
	boperand,    
	bamount,     
	btype,       
	bopcode,     
	immediate,   
	reg1,        
	reg2,        
	reg3,        
	shift_I,     
	shift_IR,    
	shift_type,  
	swapshift,   
	amount,      
	enable       
);
	`include "definition/Definition.v" 
	output		reg		[WORD-1:0]				boperand;		
	output		reg		[WORD-1:0]				bamount;		
	output		reg		[WORD-1:0]				btype;			
	output		reg		[WORD-1:0]				bopcode;		
	input				[WORD-1:0]				immediate;		
	input				[WORD-1:0]				reg1;			
	input				[WORD-1:0]				reg2;			
	input				[WORD-1:0]				reg3;			
	input				[WORD-1:0]				shift_I;		
	input				[WIDTH_SHIFT_IR-1:0]	shift_IR;		
	input				[WIDTH_SHIFT_TYPE-1:0]	shift_type;		
	input										swapshift;		
	input				[WORD-1:0]				amount;			
	input										enable;			
	always @(*) begin
		if(enable) begin 
			case(swapshift) 
				PS_SWAP: begin 
					boperand	<= reg1 | immediate; 
					bamount		<= amount; 
					btype		<= PS_SWAP; 
					bopcode		<= 0; 
				end
				PS_SHIFT: begin 
					boperand	<= reg2; 
					case(shift_IR) 
						IMM:	bamount <= shift_I; 
						REG:	bamount <= reg3; 
						default	bamount <= 0; 
					endcase
					btype		<= PS_SHIFT; 
					bopcode		<= shift_type; 
				end
				default: begin 
					boperand	<= 0; 
					bamount		<= 0; 
					btype		<= 0; 
					bopcode		<= 0; 
				end
			endcase
		end
		else begin 
			boperand	<= reg2; 
			bamount		<= 0; 
			btype		<= PS_SWAP; 
			bopcode		<= 0; 
		end
	end
endmodule 