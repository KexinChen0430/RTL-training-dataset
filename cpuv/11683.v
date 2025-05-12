module des_sbox1 
	(
		input  wire [0:5] right_xor_key_segment_din, 
		output reg  [0:3] sbox_dout 
    );
    always @(*)
    	case ({right_xor_key_segment_din[0], right_xor_key_segment_din[5]})
    		2'b00: 
    				case (right_xor_key_segment_din[1:4])
    				endcase
    		2'b01: 
    				case (right_xor_key_segment_din[1:4])
    				endcase
    		2'b10: 
    				case (right_xor_key_segment_din[1:4])
    				endcase
    		2'b11: 
    				case (right_xor_key_segment_din[1:4])
    				endcase
    	endcase 
endmodule 