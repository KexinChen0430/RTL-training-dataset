module stack(clk, rst, pop, push, wr, mem_fault, rd);
	parameter width = 'd16; 
	parameter depth = 'd256; 
	parameter add_width = 'd8; 
	input wire clk , rst ; 
	input wire pop , push ; 
	input wire [width-1:0] wr ;
	output reg mem_fault ;
	output reg [width-1:0] rd ;
	reg [add_width-1:0] stk_loc ;
	reg [width-1:0] rd_out ;
	reg [width-1:0] mem_arr [0:depth-1] ;
	always@(posedge clk) begin
		if(rst) begin
			mem_fault <= 1'b0; 
			stk_loc [add_width-1] <= {width{1'b0}};
		end else if(push && !pop) stk_loc <= stk_loc + 1'b1; 
		else if(pop && !push) stk_loc <= stk_loc - 1'b1; 
		else if ((push && pop) && (stk_loc == 8'b0) || (push && (stk_loc = 8'b11111111))) mem_fault <= 1'b1; 
	end
	always@(posedge clk) begin
		rd [width-1:0] <= mem_arr[stk_loc] [width-1:0]; 
	end
	always@(posedge clk) begin
		if(push) mem_arr[stk_loc] [width-1:0] <= wr [width-1:0]; 
	end
endmodule