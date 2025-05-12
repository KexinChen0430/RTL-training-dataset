module fifo(clock, fifo_in, fifo_out); 
	input clock; 
	input [`BITS-1:0] fifo_in; 
	output [`BITS-1:0] fifo_out; 
	wire [`BITS-1:0] fifo_out; 
	reg [`BITS-1:0] freg1; 
	assign fifo_out = freg34; 
	always @(posedge clock) 
	begin
		freg1 <= fifo_in; 
		freg34 <= freg33; 
	end
endmodule 