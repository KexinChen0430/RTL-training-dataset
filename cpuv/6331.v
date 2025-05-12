module fifo_ram
#(
	parameter DEPTH	= 12, 
	parameter WIDTH	= 32  
)
(
	input					WR_CLK,   
	input					WR_ENA,   
	input [DEPTH -1:0] 	WR_ADRS,  
	input [WIDTH -1:0]	WR_DATA,  
	input 					RD_CLK,   
	input [DEPTH -1:0] 	RD_ADRS,  
	output [WIDTH -1:0]	RD_DATA   
);
	reg [WIDTH -1:0]		ram [0:(2**DEPTH) -1]; 
	reg [WIDTH -1:0]		rd_reg; 
	always @(posedge WR_CLK) begin
		if(WR_ENA) ram[WR_ADRS] <= WR_DATA; 
	end
	always @(posedge RD_CLK) begin
		rd_reg <= ram[RD_ADRS]; 
	end
	assign RD_DATA = rd_reg; 
endmodule 