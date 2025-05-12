module sync_signal(
	input clk,			
	input in,			
	output out,			
	output falling,		
	output rising,		
);
	reg [2:0] shiftreg;
	initial begin
		shiftreg <= 0;
	end
	always @(posedge clk) begin
		shiftreg[2:1] <= shiftreg[1:0]; 
		shiftreg[0] <= in; 
	end
	assign out = shiftreg[1];
	assign falling = shiftreg[2] & ~shiftreg[1];
	assign rising = ~shiftreg[2] & shiftreg[1];
endmodule