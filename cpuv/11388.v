module edge_detect #(                           
	parameter NR_BITS = 1,					
) (
	input wire clk,							
	input wire [NR_BITS - 1 : 0] signal,	
	output wire [NR_BITS - 1 : 0] rising,	
	output wire [NR_BITS - 1 : 0] falling,	
);
	reg [NR_BITS - 1 : 0] prev_signal;       
	always @(posedge clk) begin              
		prev_signal <= signal;                
	end
	assign rising = ~prev_signal & signal;   
	assign falling = prev_signal & ~signal;  
endmodule                                   