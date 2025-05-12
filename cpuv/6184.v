module rw_manager_di_buffer ( 
	clock, 
	data, 
	rdaddress, 
	wraddress, 
	wren, 
	q, 
	clear); 
	parameter DATA_WIDTH = 32; 
	parameter ADDR_WIDTH = 4; 
	parameter NUM_WORDS = 16; 
	input	  clock; 
	input	[DATA_WIDTH-1:0]  data; 
	input	[ADDR_WIDTH-1:0]  rdaddress; 
	input	[ADDR_WIDTH-1:0]  wraddress; 
	input	  wren; 
	output	[DATA_WIDTH-1:0]  q; 
	input clear; 
	tri1	  clock; 
	tri0	  wren; 
	reg	[DATA_WIDTH-1:0]  q; 
	reg [DATA_WIDTH-1:0] mem [0:NUM_WORDS-1]; 
	integer i; 
    always @(posedge clock or posedge clear) begin 
        if (clear) begin 
			for (i = 0; i < NUM_WORDS; i = i + 1) begin 
				mem[i] <= 0; 
			end
		end
		else begin 
			if (wren) 
				mem[wraddress] <= data; 
			q <= mem[rdaddress]; 
		end
	end
endmodule