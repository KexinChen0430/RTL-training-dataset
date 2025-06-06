module div_pipelined_latch #( 
		parameter N = 4 
	)(
		input wire iCLOCK, 
		input wire inRESET, 
		input wire iREMOVE, 
		input wire iPREVIOUS_VALID, 
		output wire oPREVIOUS_BUSY, 
		input wire iPREVIOUS_SIGN, 
		input wire [31:0] iPREVIOUS_DIVISOR, 
		input wire [31:0] iPREVIOUS_DIVIDEND, 
		input wire [N-1:0] iPREVIOUS_Q, 
		input wire [30:0] iPREVIOUS_R, 
		output wire oNEXT_VALID, 
		input wire iNEXT_BUSY, 
		output wire oNEXT_SIGN, 
		output wire [31:0] oNEXT_DIVISOR, 
		output wire [31:0] oNEXT_DIVIDEND, 
		output wire [N-1:0] oNEXT_Q, 
		output wire [30:0] oNEXT_R 
	);
	reg b_valid; 
	reg b_sign; 
	reg [31:0] b_divisor; 
	reg [31:0] b_dividend; 
	reg [N-1:0] b_q; 
	reg [30:0] b_r; 
	always@(posedge iCLOCK or negedge inRESET)begin 
		if(!inRESET)begin 
			b_valid <= 1'b0; 
			b_sign <= 1'b0; 
			b_divisor <= {32{1'b0}}; 
			b_dividend <= {32{1'b0}}; 
			b_q <= {N{1'b0}}; 
			b_r <= {31{1'b0}}; 
		end
		else if(iREMOVE)begin 
			b_valid <= 1'b0; 
			b_sign <= 1'b0; 
			b_divisor <= {32{1'b0}}; 
			b_dividend <= {32{1'b0}}; 
			b_q	<= {N{1'b0}}; 
			b_r	<= {31{1'b0}}; 
		end
		else begin 
			if(!iNEXT_BUSY)begin 
				b_valid <= iPREVIOUS_VALID; 
				b_sign <= iPREVIOUS_SIGN; 
				b_divisor <= iPREVIOUS_DIVISOR; 
				b_dividend <= iPREVIOUS_DIVIDEND; 
				b_q	<= iPREVIOUS_Q; 
				b_r	<= iPREVIOUS_R; 
			end
		end
	end
	assign oPREVIOUS_BUSY = iNEXT_BUSY; 
	assign oNEXT_VALID = b_valid; 
	assign oNEXT_SIGN = b_sign; 
	assign oNEXT_DIVISOR = b_divisor; 
	assign oNEXT_DIVIDEND = b_dividend; 
	assign oNEXT_Q = b_q; 
	assign oNEXT_R = b_r; 
endmodule 