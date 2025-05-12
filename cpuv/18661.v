module shifter_32b #( 
	parameter LENGTH = 1 
) (
	input clk, 
	input [31:0] val_in, 
	output [31:0] val_out 
);
generate 
`ifdef USE_XILINX_BRAM_FOR_W 
	if(LENGTH >= 8) begin 
		reg [7:0] addr = 0; 
		reg [31:0] r, out0, out1; 
		reg [31:0] m[0:(LENGTH-4)]; 
		always @ (posedge clk) 
		begin
			addr <= (addr + 1) % (LENGTH - 3); 
			r <= m[addr]; 
			m[addr] <= val_in; 
			out0 <= r; 
			out1 <= out0; 
		end
		assign val_out = out1; 
	end
	else if (LENGTH == 5) begin 
		reg [32 * 4 - 1:0] r; 
		(* KEEP = "TRUE" *) reg [31:0] out0; 
		always @ (posedge clk) 
		begin
			r <= (r << 32) | val_in; 
			out0 <= r[32 * 4 - 1:32 * 3]; 
		end
		assign val_out = out0; 
	end
	else begin 
`endif
		reg [32 * LENGTH - 1:0] r; 
		always @ (posedge clk) 
			r <= (r << 32) | val_in; 
		assign val_out = r[32 * LENGTH - 1:32 * (LENGTH - 1)]; 
`ifdef USE_XILINX_BRAM_FOR_W
	end 
`endif
endgenerate 
endmodule 