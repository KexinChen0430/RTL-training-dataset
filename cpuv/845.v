module Key
(
	input clk,             
	input rst,             
	input left,            
	input right,           
	input up,              
	input down,            
	output reg[7:0] direction 
);
	reg [31:0] clk_cnt;        
	reg left_key_last;         
	reg right_key_last;        
	reg up_key_last;           
	reg down_key_last;         
	always@(posedge clk or negedge rst) begin
		if(!rst) begin 
			clk_cnt <= 0;
			direction <= 8'b0; 
			left_key_last <= 0; 
			right_key_last <= 0; 
			up_key_last <= 0; 
			down_key_last <= 0; 
		end
		else begin 
			if(clk_cnt == 5_0000) begin 
				clk_cnt <= 0; 
				left_key_last <= left;
				right_key_last <= right;
				up_key_last <= up;
				down_key_last <= down;
				if(left_key_last == 0 && left == 1)
					direction <= 8'b0000_0001; 
				if(right_key_last == 0 && right == 1)
					direction <= 8'b0000_0010; 
				if(up_key_last == 0 && up == 1)
					direction <= 8'b0000_0011; 
				if(down_key_last == 0 && down == 1)
					direction <= 8'b0000_0100; 
			end
			else begin 
				clk_cnt <= clk_cnt + 1; 
				direction <= 8'b0000_0000; 
			end
		end
	end
endmodule