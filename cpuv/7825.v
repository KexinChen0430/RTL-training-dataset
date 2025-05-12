module mem_data
#(
	parameter integer DWIDTH = 9,  
	parameter integer AWIDTH = 6   
)
(
		input clock,                
		input reset,                
		input [DWIDTH-1:0] data_in, 
		input [AWIDTH-1:0] wr_ptr,  
		input [AWIDTH-1:0] rd_ptr,  
		output reg [DWIDTH-1:0] data_out 
);
	reg [DWIDTH-1:0] MEM [0:2**AWIDTH-1];
	always@(posedge clock or negedge reset)
	begin
		if (!reset) 
		begin
			MEM[0]  <= {(DWIDTH){1'b0}};
			MEM[63] <= {(DWIDTH){1'b0}};
			data_out  <= 9'd0; 
		end
		else 
		begin
			MEM[wr_ptr] <= data_in; 
			data_out <= MEM[rd_ptr]; 
		end
	end
endmodule