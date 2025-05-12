module des_sbox2
	(
		input  wire [0:5] right_xor_key_segment_din, 
		output reg  [0:3] sbox_dout 
	);
	always @(*)
		case ({right_xor_key_segment_din[0], right_xor_key_segment_din[5]})
			2'b00:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd15;
						4'd1:	sbox_dout = 4'd1;
						4'd15:	sbox_dout = 4'd10;
					endcase 
			2'b01:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd3;
						4'd15:	sbox_dout = 4'd5;
					endcase 
			2'b10:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd0;
						4'd15:	sbox_dout = 4'd15;
					endcase 
			2'b11:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd13;
						4'd15:	sbox_dout = 4'd9;
					endcase 
		endcase 
endmodule 