module phase_shift (
	input RST, 
	input PWRDWN, 
	input clk, 
	input signed [31:0] shift_1000, 
	input [31:0] clk_period_1000, 
	input [6:0] duty_cycle, 
	output reg lock, 
	output reg clk_shifted); 
	always @(posedge clk or posedge RST or posedge PWRDWN) begin 
		if (!RST && !PWRDWN) begin 
			if (shift_1000 < 0) begin 
				clk_shifted <= #((clk_period_1000 / 1000.0) + ((shift_1000 / 1000.0) * ((clk_period_1000 / 1000.0) / 360.0))) 1; 
			end else begin
				clk_shifted <= #((shift_1000 / 1000.0) * ((clk_period_1000 / 1000.0) / 360.0)) 1; 
			end
		end
	end
	always @(negedge clk or posedge RST) begin 
		if (RST) begin 
			clk_shifted <= 1'b0; 
			lock <= 1'b0; 
		end else if (lock !== 1'bx) begin 
			if (shift_1000 < 0) begin 
				clk_shifted <= #((clk_period_1000 / 1000.0) + ((shift_1000/ 1000.0)  * ((clk_period_1000 / 1000.0) / 360.0)) + ((duty_cycle + 50.0) * ((clk_period_1000 / 1000.0) / 100.0))) 0; 
				lock <= #((clk_period_1000 / 1000.0) + ((shift_1000/ 1000.0)  * ((clk_period_1000 / 1000.0) / 360.0)) + ((duty_cycle + 50.0) * ((clk_period_1000 / 1000.0) / 100.0))) 1'b1; 
			end else begin
				clk_shifted <= #((shift_1000/ 1000.0)  * ((clk_period_1000 / 1000.0) / 360.0) + ((duty_cycle + 50.0) * ((clk_period_1000 / 1000.0) / 100.0))) 0; 
				lock <= #((shift_1000/ 1000.0)  * ((clk_period_1000 / 1000.0) / 360.0) + ((duty_cycle + 50.0) * ((clk_period_1000 / 1000.0) / 100.0))) 1'b1; 
			end
		end
	end
	always begin 
		if (PWRDWN) begin 
			clk_shifted <= 1'bx; 
			lock <= 1'bx; 
			#0.001; 
		end else begin
		#1; 
		end;
	end
endmodule