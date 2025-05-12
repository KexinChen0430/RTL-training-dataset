module LCD_display_string(index,out,state_code); 
input [4:0] index; 
input [4:0] state_code; 
output [7:0] out; 
reg [7:0] out; 
always
  case (index) 
	5'h00: case (state_code) 
			 5'b10000: out <= 8'h44; 
			 default: out <= 8'h53; 
			 endcase
	5'h01: case (state_code) 
			 5'b00000: out <= 8'h74; 
			 5'b10000: out <= 8'h6F; 
			 default: out <= 8'h65; 
			 endcase
	5'h10: out <= 8'h50; 
	5'h11: out <= 8'h72; 
	default: out <= 8'h20; 
  endcase
endmodule