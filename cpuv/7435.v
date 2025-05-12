module regs(
	clk,       
	en_write,      
	data_write,    
	addr_write,    
	addr_read1,    
	addr_read2,    
	data_read1,     
	data_read2
);
`include "params_proc.v"
input clk, en_write;
input signed [DATA_WIDTH-1:0] data_write;
input [REG_ADDR_WIDTH-1:0] addr_write, addr_read1, addr_read2;
output [DATA_WIDTH-1:0] data_read1, data_read2;
reg [DATA_WIDTH-1:0] ram [0:(1<<REG_ADDR_WIDTH)-1];
always @ (posedge clk) begin
	if (en_write) begin
		ram[addr_write] <= data_write;
	end
end
assign data_read1 = (addr_write == addr_read1 && en_write ? data_write : ram[addr_read1]);
assign data_read2 = (addr_write == addr_read2 && en_write ? data_write : ram[addr_read2]);
initial begin
	ram[0] <= 0;
	ram[1] <= 1;
end
endmodule