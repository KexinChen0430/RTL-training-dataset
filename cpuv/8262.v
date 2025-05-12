module ram_packed #(parameter elementWidth = 32,	
                    parameter depth = 256, 
                    parameter addrWidth = log2(depth))	
                    (input clk,	
                    input [(elementWidth-1):0] data,	
                    input [(addrWidth-1):0] write_addr,	
                    input [(addrWidth-1):0] read_addr,	
                    input we,	
                    output [(elementWidth-1):0] q);	
	reg [(elementWidth-1):0] ram[0:(depth-1)];	
	always @ (posedge clk) begin	
		if (we)	
			ram[write_addr] = data;	
		q <= ram[read_addr];	
	end
endmodule