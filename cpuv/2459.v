module ballcollisions(
	clk,        
	reset,      
	p1_y,       
	p2_y,       
	ball_x,     
	ball_y,     
	dir_x,      
	dir_y,      
	oob         
	);
input clk, reset;
input [10:0] p1_y, p2_y, ball_x, ball_y;
output dir_x, dir_y, oob;
reg dir_x, dir_y, oob;
initial begin
	dir_x <= 0;  
	dir_y <= 1;  
	oob <= 0;    
end
always @ (posedge clk) begin
	if (reset) begin
		dir_x <= ~dir_x;  
		dir_y <= 1;       
		oob <= 0;         
	end
	else begin
		if (ball_x <= 0 || ball_x >= `hc) begin
			oob = 1;  
		end
		else begin
			oob = 0;  
		end
		if (ball_y <= `va + 5) begin
			dir_y = 1;  
		end
		if (ball_y >= `vc - `ballsize) begin
			dir_y = 0;  
		end
		if (ball_x <= `batwidth && ball_y + `ballsize >= p1_y && ball_y <= p1_y + `batheight) begin
			dir_x = 1;  
			if (ball_y + `ballsize <= p1_y + (`batheight / 2)) begin
				dir_y = 0;  
			end
			else begin
				dir_y = 1;  
			end
		end
		else if (ball_x >= `hc - `batwidth -`ballsize && ball_y + `ballsize <= p2_y + `batheight && ball_y >= p2_y) begin
			dir_x = 0;  
			if (ball_y + `ballsize <= p2_y + (`batheight / 2)) begin
				dir_y = 0;  
			end
			else begin
				dir_y = 1;  
			end
		end
	end
end
endmodule