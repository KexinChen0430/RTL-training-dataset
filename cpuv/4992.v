module FSM_Ctrol (
	input			RST,	
	input			CLK,	
	input			STM,	
	output reg		ENpH,	
	output reg		ENpL,	
	output reg		ENa,	
	output reg		ENr,	
	output reg		SEL,	
	output reg		EOM		
	);
	reg[2:0]	Qp,Qn; 
	always @ *
	begin : Combinacional
		case (Qp) 
			3'b000 : begin	
			end
			3'b001 : begin 
			end
			3'b010 : begin 
			end
			3'b011 : begin 
			end
		endcase
	end
	always @ (posedge RST or posedge CLK)
	begin : Secuencial
	end
endmodule