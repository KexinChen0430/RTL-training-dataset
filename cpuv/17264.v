module ROM
(
	input  wire[15:0]  		iAddress,       
	output reg [27:0] 		oInstruction    
);
always @ ( iAddress )
begin
	case (iAddress)
		0: oInstruction = { `NOP ,24'd400    }; 
		1: oInstruction = { `STO ,`R1,16'd3};   
		2: oInstruction = { `STO ,`R2,16'd7};   
		3: oInstruction = { `SMUL ,`R4, `R1, `R3}; 
		4: oInstruction = { `LED ,8'b0, `R4,8'b0 }; 
		5: oInstruction = { `JMP ,  8'd1,16'b0   }; 
		default:
			oInstruction = { `LED ,  24'b10101010 };		
	endcase
end
endmodule