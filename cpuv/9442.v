module keypressed(clock, reset, enable_in, enable_out); 
input clock; 
input reset; 
input enable_in; 
output reg enable_out; 
reg [1:0] key_state, next_key_state; 
parameter [1:0] KEY_FREE = 2'b00, KEY_PRESSED = 2'b01, KEY_RELEASED = 2'b10; 
always @(posedge clock or negedge reset) begin 
	if (reset == 1'b0) 
		key_state <= KEY_FREE; 
	else 
		key_state <= next_key_state; 
end
always @(key_state, enable_in) begin 
	next_key_state = key_state; 
	case (key_state) 
		KEY_FREE: if (enable_in == 1'b0) next_key_state = KEY_PRESSED; 
		KEY_PRESSED: if (enable_in == 1'b1) next_key_state = KEY_RELEASED; 
		KEY_RELEASED: next_key_state = KEY_FREE; 
		default: next_key_state = 2'bxx; 
	endcase
end
always @(key_state) begin 
	enable_out = 1'b0; 
	case (key_state) 
		KEY_FREE: enable_out = 1'b0; 
		KEY_PRESSED: enable_out = 1'b0; 
		KEY_RELEASED: enable_out = 1'b1; 
		default: enable_out = 1'bx; 
	endcase
end
endmodule 