module if the given period length (ref_period) can be trusted */ 
input period_stable, 
input [31:0] ref_period_1000, 
input clk, 
output reg out, 
output reg [31:0] out_period_length_1000); 
reg start; 
always begin 
	if (PWRDWN) begin 
		out <= 1'bx;
		start <= 1'bx;
		#1;
	end else if (RST) begin 
		out <= 1'b0;
		start <= 1'b0;
		#1;
	end else if (ref_period_1000 > 0 && start) begin 
		out_period_length_1000 <= ((ref_period_1000 / 1000.0) * ((D * (O_1000 / 1000.0) * 1.0) / (M_1000 / 1000.0)) * 1000);
		out <= ~out;
		#(((ref_period_1000 / 1000.0) * ((D * (O_1000 / 1000.0) * 1.0) / (M_1000 / 1000.0))) / 2.0);
	end else begin 
		out <= 1'b0;
		#1;
	end
end
always @(posedge clk) begin 
	if (period_stable && !start) begin 
		#((ref_period_1000 / 1000.0) - 1);
		start <= 1'b1;
	end else if (!period_stable) begin 
		start <= 1'b0;
	end
end
endmodule 