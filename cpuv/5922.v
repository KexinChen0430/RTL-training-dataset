module mutex #( 
	parameter ADDRESS_WIDTH=31, 
	parameter DATA_WIDTH=32, 
	parameter MAX_K_VALUES 
) (
        input clk, 
        input reset, 
	output wire grant_accum, 
	output wire grant_compute, 
	input [31:0] accum_key, 
	input [31:0] locked_accum_key, 
	input [31:0] compute_key, 
	input [MAX_K_VALUES*DATA_WIDTH-1:0] locked_sort_keys, 
	input [31:0] locked_compute_key, 
	output wire accum_key_locked, 
	output wire compute_key_locked, 
	input wire [MAX_K_VALUES-1:0] mask_reg 
);
wire [MAX_K_VALUES-1:0] is_equal; 
reg grant_counter; 
assign grant_accum = grant_counter; 
assign grant_compute = ~grant_counter; 
assign compute_key_locked = (compute_key==locked_accum_key)?1'b1:1'b0; 
assign accum_key_locked = |is_equal||(accum_key==locked_compute_key); 
genvar i; 
generate
        for(i=0;i<MAX_K_VALUES;i=i+1) begin:equal 
                assign is_equal[i] = mask_reg[i] & ((accum_key==locked_sort_keys[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i])?1'b1:1'b0); 
        end
endgenerate
always@(posedge clk) 
begin
	if(reset) begin 
		grant_counter <= 0; 
	end
	else begin 
		grant_counter <= ~grant_counter; 
	end
end
endmodule 