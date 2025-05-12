module mem_dport_sclk(
	clk,       
	we_a,      
	we_b,      
	data_a,    
	data_b,    
	addr_a,    
	addr_b,    
	out_a,     
	out_b      
);
`include "params_proc.v"
input clk, we_a, we_b; 
input signed [DATA_WIDTH-1:0] data_a, data_b; 
input [MEM_WIDTH-1:0] addr_a, addr_b; 
output reg [DATA_WIDTH-1:0] out_a, out_b; 
reg [DATA_WIDTH-1:0] ram [0:(1<<MEM_WIDTH)-1];
always @ (posedge clk) begin
	if (we_a) begin 
		ram[addr_a] <= data_a; 
		out_a <= data_a; 
	end else begin 
		out_a <= ram[addr_a]; 
	end
end
always @ (posedge clk) begin
	if (we_b) begin 
		ram[addr_b] <= data_b; 
		out_b <= data_b; 
	end else begin 
		out_b <= ram[addr_b]; 
	end
end
endmodule