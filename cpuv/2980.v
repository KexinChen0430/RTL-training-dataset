module seg7_ctrl(
	input [3:0] char_id, 
	output [6:0] segs    
);
always @(*)
	case (char_id)
		4'h0: segs = ~7'b0111111; 
		4'h1: segs = ~7'b0000110; 
		4'h2: segs = ~7'b1011011; 
		4'h3: segs = ~7'b1001111; 
		4'h4: segs = ~7'b1100110; 
		4'h5: segs = ~7'b1101101; 
		4'h6: segs = ~7'b1111101; 
		4'h7: segs = ~7'b0000111; 
		4'h8: segs = ~7'b1111111; 
		4'h9: segs = ~7'b1101111; 
		4'hA: segs = ~7'b1001001; 
		4'hB: segs = ~7'b1010100; 
		4'hC: segs = ~7'b0111001; 
		4'hD: segs = ~7'b1100110; 
		4'hE: segs = ~7'b0111000; 
		default: segs = ~7'b0000000;
	endcase
endmodule