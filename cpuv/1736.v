module int_action_rom(
	int_func_id,
	int_payload
);
	parameter LC_INT_DEPTH = 8;
	parameter LC_RF_DEPTH = 128;		
	parameter LC_MEM_DEPTH = 65536;	
	output	[`FUNC_WIDTH*LC_INT_DEPTH-1:0] int_func_id;
	output 	[(`DATA_WIDTH<<1)*LC_INT_DEPTH-1:0] int_payload;
reg		[`FUNC_WIDTH-1:0] int_func_array [0:LC_INT_DEPTH-1];
reg		[(`DATA_WIDTH<<1)-1:0] int_payload_array [0:LC_INT_DEPTH-1];
genvar idx;
generate
	for (idx=0; idx<LC_INT_DEPTH; idx=idx+1)
	begin: INT_ACTION
		assign int_func_id[`FUNC_WIDTH*(idx+1)-1:`FUNC_WIDTH*idx] = int_func_array[idx];
		assign int_payload[(`DATA_WIDTH<<1)*(idx+1)-1:(`DATA_WIDTH<<1)*idx] = int_payload_array[idx];
	end
endgenerate
integer i;
initial
begin
	for (i=0; i<LC_INT_DEPTH; i=i+1)
	begin
		int_func_array[i] <= 0;
		int_payload_array[i] <= 0;
	end
	int_func_array[0] <= `LC_CMD_RF_READ;
	int_payload_array[0] <= (((8'h0<<24 | 8'h1<<16 | 8'h03<<8 | 8'h0)<<`DATA_WIDTH) | {(`DATA_WIDTH){1'b0}});	
	int_func_array[1] <= `LC_CMD_RF_READ;
	int_payload_array[1] <= ((((LC_RF_DEPTH-1'b1)<<24 | 8'h2<<16 | 8'h03<<8 | 8'h0)<<`DATA_WIDTH) | {(`DATA_WIDTH){1'b0}});	
	int_func_array[2] <= `LC_CMD_MEM_READ;
	int_payload_array[2] <= (((30'h0<<2) | 2'b0)<<32) | ((8'h03<<24) | 24'h1);	
	int_func_array[3] <= `LC_CMD_MEM_READ;
	int_payload_array[3] <= ((((LC_MEM_DEPTH-1'b1)<<2) | 2'b0)<<32) | ((8'h03<<24) | 24'h2);	
	int_func_array[4] <= `LC_CMD_RF_WRITE;
	int_func_array[5] <= `LC_CMD_RF_WRITE;
	int_func_array[6] <= `LC_CMD_MEM_WRITE;
	int_func_array[7] <= `LC_CMD_MEM_WRITE;
end
endmodule