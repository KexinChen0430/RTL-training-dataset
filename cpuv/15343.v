module b_right_shifter (
	shift_in,      
	shift_value,   
	shift_out      
);
input [47:0] shift_in;
input [5:0] shift_value;
output [47:0] shift_out;
reg [47:0] shift_out;
always @(shift_value)
begin
	case (shift_value)
		6'b000000: shift_out = shift_in;          
		6'b000001: shift_out = shift_in >> 1;     
		6'b000010: shift_out = shift_in >> 2;     
		6'b101111: shift_out = shift_in >> 47;    
		6'b110000: shift_out = shift_in >> 48;    
	endcase
end
endmodule 