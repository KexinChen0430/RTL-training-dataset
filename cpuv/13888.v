module ra2seg(
	input [10:0] r,       
	output reg [6:0] seg  
);
	always @ (r) begin
		if (r[10]) seg <= `SSEG_R;      
		else if (r[6]) seg <= `SSEG_I;  
		else if (r[5]) seg <= `SSEG_A;  
		else if (r[4]) seg <= `SSEG_A;  
		else if (r[3]) seg <= `SSEG_I;  
		else if (r[2]) seg <= `SSEG_S;  
		else if (r[1]) seg <= `SSEG_I;  
		else if (r[0]) seg <= `SSEG_II; 
		else seg <= `SSEG_NONE;         
	end
endmodule