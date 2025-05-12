module Seg_Display
(
	input clk,          
	input rst,          
	input add_cube,     
	inout [1:0]game_status, 
	output reg[15:0]point,  
	output reg[7:0]seg_out, 
	output reg[3:0]sel      
);
localparam RESTART = 2'b00;
reg[31:0]clk_cnt;
always@(posedge clk or negedge rst)
begin
	if(!rst)
		begin
			seg_out <= 0; 
			clk_cnt <= 0; 
			sel <= 0;     
		end
	else if (game_status == RESTART) begin
		seg_out <= 0; 
		clk_cnt <= 0; 
		sel <= 0;     
	end
	else
		begin
			if(clk_cnt <= 20_0000)
			begin
				clk_cnt <= clk_cnt+1;
			end
			else
				clk_cnt <= 0;
		end
end
reg addcube_state;
always@(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				point <= 0;          
				addcube_state <= 0;  
			end
		else if (game_status == RESTART) begin
			point <= 0;          
			addcube_state <= 0;  
		end
		else begin
		end
end
endmodule