module Timer (rst, clk, Beg, Ready, Cycend, scrinit);
	input rst; 
	input	clk; 
	input Beg; 
	input [2:0] scrinit; 
	output reg Ready, Cycend; 
	reg temp_ready; 
	reg temp_cycend; 
	reg [20:0]temp; 
initial begin
	Ready=0; 
	temp=21'b111111111111111111111; 
end
always @(negedge clk) begin
	if(rst) begin 
		temp = 0; 
		temp_ready=0; 
		temp_cycend=0; 
	end
	else begin 
		if(scrinit == 3'b110) begin 
			if(temp == 250000)begin 
				temp_ready = 1; 
				temp_cycend = 0; 
				temp = temp+1; 
			end
			else begin 
				if(Beg) begin 
			  	temp = 0; 
					temp_ready=0; 
					temp_cycend = 0; 
				end
			  else begin 
					if(temp == 21'b111111111111111111111) begin 
						temp=0; 
						temp_ready=0; 
						temp_cycend=0; 
					end
					else begin 
						if(temp == 260000) begin 
							temp = temp+1; 
							temp_ready=1; 
							temp_cycend=1; 
						end
						else 
			  			temp = temp+1; 
					end
				end
			end
		end
		else begin 
			if(temp == 2060000)begin 
				temp_ready = 1; 
				temp_cycend = 0; 
				temp = temp+1; 
			end
			else begin 
				if(Beg) begin 
			  	temp = 0; 
					temp_ready=0; 
					temp_cycend = 0; 
				end
			  else begin 
					if(temp == 21'b111111111111111111111) begin 
						temp=0; 
						temp_ready=0; 
						temp_cycend=0; 
					end
					else begin 
						if(temp == 2097150) begin 
							temp = temp+1; 
							temp_ready=1; 
							temp_cycend=1; 
						end
						else 
			  			temp = temp+1; 
					end
				end
			end
		end
	end
end
always @(temp_ready or temp_cycend) begin
	Ready=temp_ready; 
	Cycend=temp_cycend; 
end
endmodule