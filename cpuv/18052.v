module b(clock,
		a_in,
		b_in,
		out);
input	clock;
input [`BITS-1:0] a_in;
input [`BITS-1:0] b_in;
reg [`BITS-1:0] temp;
output [`BITS-1:0]    out;
reg [`BITS-1:0] out;
always @(posedge clock)
begin
	temp <= a_in | b_in;
	out <= a_in ^ temp;
end
endmodule