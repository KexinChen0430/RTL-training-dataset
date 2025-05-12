module pippo_barrel (
	shift_in,
	shift_cnt,
	shift_left,
	shift_arith,
	shift_mode_32b,
    shrot_out
	);
parameter width = `OPERAND_WIDTH; 
input   [width-1:0]     shift_in;   
input   [5:0]           shift_cnt;	
input   shift_left;		    
input   shift_arith;        
input   shift_mode_32b;     
output [width-1:0] shrot_out; 
wire                fill_32b; 
reg     [95:0]      shifted_32b; 
wire    [95:0]      sht_operand_32b; 
wire    [64:0]      shift_out_32b; 
assign fill_32b = shift_in[31] & shift_arith & shift_mode_32b; 
assign sht_operand_32b = {({32{fill}}), shift_in[31:0], 32'b0}; 
always @ (sht_operand or shift_left or shift_cnt) begin 
	if (shift_left)
		shifted_32b = sht_operand_32b << shift_cnt[4:0]; 
	else
		shifted_32b = sht_operand_32b >> shift_cnt[4:0]; 
end
assign shift_out_32b = {32{shifted_32b[63]}, shifted_32b[63:32]}; 
wire                fill_64b; 
reg     [191:0]     shifted_64b; 
wire    [191:0]     sht_operand_64b; 
wire    [63:0]      shift_out_64b; 
assign fill_64b = shift_in[63] & shift_arith & (!shift_mode_32b); 
assign sht_operand_64b = {({64{fill}}), shift_in[63:0], 64'b0}; 
always @ (sht_operand_64b or shift_left_64b or shift_cnt) begin 
	if (shift_left)
		shifted_64b = sht_operand_64b << shift_cnt[5:0]; 
	else
		shifted_64b = sht_operand_64b >> shift_cnt[5:0]; 
end
assign shift_out_64b = shifted_64b[127:64]; 
assign shrot_out = shift_mode_32b ? shift_out_32b : shift_out_64b; 
endmodule