module des_sbox4 
(
		input  wire [0:5] right_xor_key_segment_din, 
		output reg  [0:3] sbox_dout 
);
always @(*) 
		case ({right_xor_key_segment_din[0], right_xor_key_segment_din[5]}) 
			2'b00: 
					case (right_xor_key_segment_din[1:4]) 
						4'd0:	sbox_dout = 4'd7;
						4'd1:	sbox_dout = 4'd13;
					endcase
			2'b01: 
					case (right_xor_key_segment_din[1:4]) 
						4'd0:	sbox_dout = 4'd13;
						4'd1:	sbox_dout = 4'd8;
					endcase
		endcase 
endmodule 