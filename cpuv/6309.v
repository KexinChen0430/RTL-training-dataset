module ROM
(
	input  wire[15:0]  		iAddress, 
	output reg [27:0] 		oInstruction 
);
always @ ( iAddress ) 
begin
	case (iAddress) 
	0: oInstruction = { `NOP ,24'd4000    }; 
	1: oInstruction = { `STO ,`R1, 16'h0002}; 
	2: oInstruction = { `STO ,`R2, 16'h0008}; 
	3: oInstruction = { `STO ,`R3, 16'h0003}; 
	4: oInstruction = { `CALL, 8'd14, 16'd0}; 
	5: oInstruction = { `STO ,`R0, 16'h0000}; 
	6: oInstruction = { `CALL, 8'd9, 16'b0   }; 
	7: oInstruction = { `NOP , 24'd4000      }; 
	8: oInstruction = { `JMP , 8'd7, 16'b0   }; 
	9: oInstruction = { `STO ,`R1, 16'h0001}; 
	10: oInstruction = {`ADD ,`R2, `R2, `R1}; 
	11: oInstruction = {`NOP ,24'd4000 }; 
	12: oInstruction = {`RET ,24'd0    }; 
	13: oInstruction = {`NOP ,24'd4000 }; 
	14: oInstruction = {`STO ,`R1, 16'h0000}; 
	15: oInstruction = {`STO ,`R4, 16'h0001}; 
	16: oInstruction = {`ADD ,`R1, `R1, `R2}; 
	17: oInstruction = {`SUB ,`R3, `R3, `R4}; 
	18: oInstruction = {`BLE ,8'd16, `R4, `R3}; 
	19: oInstruction = {`RET ,24'd0	}; 
	default:
		oInstruction = { `LED ,  24'b10101010 };		
	endcase
end
endmodule