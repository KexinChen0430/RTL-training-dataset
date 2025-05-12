module agnus_blitter_barrelshifter
(
	input	desc,			
	input	[3:0] shift,	
	input 	[15:0] new_val,	
	input 	[15:0] old_val,	
	output	[15:0] out		
);
wire [35:0] shifted_new;	
wire [35:0] shifted_old;	
reg  [17:0] shift_onehot;	
always @(desc or shift)
	case ({desc,shift[3:0]})
assign shifted_new = ({2'b00,new_val[15:0]})*shift_onehot; 
assign shifted_old = ({2'b00,old_val[15:0]})*shift_onehot; 
assign out = desc ? shifted_new[15:0] | shifted_old[31:16] : shifted_new[31:16] | shifted_old[15:0];
endmodule