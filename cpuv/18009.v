module a(clock,
		a_in,
		out);
input	clock;
input [`BITS-1:0] a_in;
output [`BITS-1:0] out;
reg [`BITS-1:0] out;
reg [`BITS-1:0] out1;
reg [`BITS-1:0] out2;
always @(posedge clock)
begin
	case (a_in)
		2'b00: out2 <= 2'b11 ;
		2'b01: out1 <= 2'b10 ;
		2'b10: out1 <= 2'b01 ;
		2'b11: out1 <= 2'b00 ;
	endcase
	out <= out1 & out2;
end
endmodule