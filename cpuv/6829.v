module wRegWriteControl (
	input                       clk         , 
	input                       rst_n       , 
	input  [               7:0] IR          , 
	input  [`EX_STATE_BITS-1:0] executeState, 
	input  [   `DATA_WIDTH-1:0] aluResultIn , 
	input  [   `DATA_WIDTH-1:0] gprIn       , 
	output [   `DATA_WIDTH-1:0] wROut         
);
reg [`DATA_WIDTH-1:0] wR;
assign wROut = wR;
always @(posedge clk) begin
		if (!rst_n) begin
			wR <= `DATA_WIDTH'b0;
		end
		else begin
			case (executeState)
				`EX_Q1: begin
				end
				`EX_Q2: begin
				end
				`EX_Q3: begin
				end
				`EX_Q4_CLRF: begin
				end
				`EX_Q4_CLRW: begin
					wR <= 0;
				end
				`EX_Q4_FSZ: begin
					if (!IR[5]) begin
						wR <= aluResultIn;
					end
				end
				`EX_Q4_MOVF: begin
					if (! IR[5]) begin
						wR <= gprIn;
					end
				end
				`EX_Q4_MOVWF: begin
				end
				`EX_Q4_BXF: begin
				end
				`EX_Q4_BTFSX: begin
				end
				`EX_Q4_CALL: begin
				end
				`EX_Q4_CLRWDT: begin
				end
				`EX_Q4_GOTO: begin
				end
				`EX_Q4_MOVLW: begin
					wR <= IR[7:0];
				end
				`EX_Q4_OPTION: begin
				end
				`EX_Q4_RETLW: begin
					wR <= IR[7:0];
				end
				`EX_Q4_SLEEP: begin
				end
				`EX_Q4_TRIS: begin
				end
				`EX_Q4_ELSE: begin
					if (!IR[5]) begin
						wR <= aluResultIn;
					end
				end
				`EX_Q4_ALUXLW: begin
					wR <= aluResultIn;
				end
				`EX_Q4_NOP: begin
				end
				default: ;
			endcase
		end
	end
endmodule