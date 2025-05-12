module alu (reg_A,reg_B,ctrl_ww,alu_op,result); 
	output [0:127] result; 
	input [0:127] reg_A; 
	input [0:127] reg_B; 
	input [0:1] ctrl_ww; 
	input [0:4] alu_op; 
	reg [0:127] result;		
	always @(reg_A or reg_B or ctrl_ww or alu_op)
	begin
		case(alu_op)
			`aluwmuleu:
			begin
				case(ctrl_ww)
					`w8:	
					begin
					end
					`w16:	
					begin
					end
					default:	
						begin
						result=128'd0;
						end
					endcase
			end
			`aluwmulou:
			begin
				case(ctrl_ww)
					`w8:	
					begin
					end
					`w16:	
					begin
					end
					default:	
						begin
						result=128'd0;
						end
					endcase
			end
			default:
			begin
				result=128'd0;
			end
		endcase
	end
endmodule 