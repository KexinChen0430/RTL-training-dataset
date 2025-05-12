module rb2seg(
	input [10:0] r,       
	output reg [6:0] seg  
);
	always @ (r) begin
		if (r[10]) begin
			case (r[9:7])
				3'd0 : seg <= `SSEG_0;    
				3'd1 : seg <= `SSEG_1_;   
				3'd2 : seg <= `SSEG_2;    
				3'd3 : seg <= `SSEG_3;    
				3'd4 : seg <= `SSEG_4;    
				3'd5 : seg <= `SSEG_5;    
				3'd6 : seg <= `SSEG_6;    
				3'd7 : seg <= `SSEG_7;    
				default : seg <= `SSEG_NONE; 
			endcase
		end else begin
			if (r[6]) seg <= `SSEG_C;      
			else if (r[5]) seg <= `SSEG_C; 
			else if (r[4]) seg <= `SSEG_R; 
			else if (r[3]) seg <= `SSEG_R; 
			else if (r[2]) seg <= `SSEG_R; 
			else if (r[1]) seg <= `SSEG_N; 
			else if (r[0]) seg <= `SSEG_II; 
			else seg <= `SSEG_NONE;        
		end
	end
endmodule