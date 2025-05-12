module.
	reg [2:0] sel_color; 
	assign red = sel_color[0];
	assign yellow = sel_color[1];
	assign green = sel_color[2];
	always @(posedge time_signal or negedge reset)
	begin
		if (!reset) 
			begin							
				timer <= 8'd0;
				sel_color <= 3'b110; 
			end
		else 
			begin 
				if (timer < tril_time)	
					timer <= timer + 8'd1; 
				else
					timer <= 8'd0; 	
				if (timer <= red_time) 
					sel_color <= 3'b110; 
				if (timer > red_time && timer <= red_time + yellow_time) 
					sel_color <= 3'b100; 
				if (timer > red_time + yellow_time && timer <= red_time + yellow_time + green_time) 
					sel_color <= 3'b011; 
				if (timer > red_time + yellow_time + green_time && timer <= red_time + yellow_time + green_time + blnk_time)
					if (sel_color == 3'b011)
						sel_color <= 3'b111; 
					else
						sel_color <= 3'b011; 
				if	(timer > red_time + yellow_time + green_time + blnk_time)
					sel_color <= 3'b101; 
			end
	end
endmodule