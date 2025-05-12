module deadtime(
	input clk, 
	input pwmin, 
	input enablepwm, 
	input run, 
	output [1:0] pwmout, 
	output [3:0] pwmout4); 
	reg [1:0] qualifiedpwm2;
	reg [1:0] pwmoutreg;
	reg [3:0] pwmoutreg4;
	`ifdef WITH_DEADTIME
	reg [2:0] counter = 0; 
	reg [2:0] pwmlastin = 2'b00; 
	`endif
	assign pwmout4 = pwmoutreg4; 
	assign pwmout = pwmoutreg; 
	always @(*) begin
		case(pwmoutreg)
			2'b00: pwmoutreg4 <= 4'b0000; 
			2'b01: pwmoutreg4 <= 4'b0110; 
			2'b10: pwmoutreg4 <= 4'b1001; 
			2'b11: pwmoutreg4 <= 4'b0101; 
			default: pwmoutreg4 <= 4'bxxxx; 
		endcase
		if(enablepwm) begin
			if(run) begin
				qualifiedpwm2[0] <= pwmin; 
				qualifiedpwm2[1] <= ~pwmin; 
			end
			else begin
				qualifiedpwm2[0] <= 1; 
				qualifiedpwm2[1] <= 1; 
			end
		end
		else begin
			if(run) begin
				qualifiedpwm2[0] <= 0; 
				qualifiedpwm2[1] <= 0; 
			end
			else begin
				qualifiedpwm2[0] <= 1; 
				qualifiedpwm2[1] <= 1; 
			end
		end
		`ifndef WITH_DEADTIME
			pwmoutreg[0] <= qualifiedpwm[0];
			pwmoutreg[1] <= qualifiedpwm[1];
		`else
			if(counter != 7) begin
				pwmoutreg[0] <= 0; 
				pwmoutreg[1] <= 0; 
			end
			else begin
				pwmoutreg[0] <= pwmlastin[0]; 
				pwmoutreg[1] <= pwmlastin[1]; 
			end
		`endif
	end
	`ifdef WITH_DEADTIME
	always @(posedge clk) begin
		if(counter != 7)
			counter <= counter + 1; 
		else if(qualifiedpwm2 != pwmlastin) begin
			counter <= 0; 
			pwmlastin <= qualifiedpwm2; 
		end
	end
	`endif
endmodule