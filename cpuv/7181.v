module r_RECEIVE_DETECT(output reg [7:0] reg_0x2F, input wire reset, input wire wenb, input wire [7:0] in_data, input wire clk);
	always@(posedge clk)
	begin
		if(reset==0) begin
			if(wenb==0)
				reg_0x2F<=in_data; 
			else
				reg_0x2F<=reg_0x2F; 
		end
		else
			reg_0x2F<=8'h00; 
	end
endmodule