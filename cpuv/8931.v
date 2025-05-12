module with another configuration; 
localparam dw = lpm_width; 
localparam aw = lpm_widthad; 
input [aw-1:0] address; 
input inclock; 
input outclock; 
input [dw-1:0] data; 
input we; 
output [dw-1:0] q; 
reg	[dw-1:0]	mem [(1<<aw)-1:0];	
reg	[aw-1:0]	addr_reg;		
assign q = mem[addr_reg]; 
always @(posedge inclock) 
    addr_reg <= #1 address; 
always @(posedge inclock) 
	if (we) 
		mem[address] <= #1 data; 
endmodule 