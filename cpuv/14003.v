module tp_channel_mux 
(
	input clk, 
	input reset, 
	input [4:0]sel, 
	input [31:0]in, 
	output reg out 
);
	always @(posedge clk or posedge reset) 
	begin
		if (reset) out <= 0; 
		else
		begin
			case (sel) 
				5'd0:  out <= in[0]; 
				5'd1:  out <= in[1]; 
				5'd31: out <= in[31]; 
			endcase 
		end
	end
endmodule 