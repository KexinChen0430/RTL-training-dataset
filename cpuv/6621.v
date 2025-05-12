module ac97_framer(
	input sys_clk, 
	input sys_rst, 
	input down_ready, 
	output down_stb, 
	output reg down_sync, 
	output reg down_data, 
	input en, 
	output reg next_frame, 
	input addr_valid, 
	input [19:0] addr, 
	input data_valid, 
	input [19:0] data, 
	input pcmleft_valid, 
	input [19:0] pcmleft, 
	input pcmright_valid, 
	input [19:0] pcmright 
);
reg [7:0] bitcounter;
reg slot_bit;
always @(*) begin
	case(bitcounter)
		8'd16: slot_bit = addr[19];
		8'd95: slot_bit = pcmright[0];
		default: slot_bit = 1'bx;
	endcase
end
reg in_slot;
always @(posedge sys_clk) begin
	if(sys_rst) begin
		bitcounter <= 8'd0;
		down_sync <= 1'b0;
		down_data <= 1'b0;
		in_slot <= 1'b0;
	end else begin
		if(en)
			next_frame <= 1'b0;
		if(down_ready & en) begin
			if(bitcounter == 8'd255)
				next_frame <= 1'b1;
			if(bitcounter == 8'd255)
				down_sync <= 1'b1;
			if(bitcounter == 8'd15)
				down_sync <= 1'b0;
			if(bitcounter == 8'd15)
				in_slot <= 1'b1;
			if(bitcounter == 8'd95)
				in_slot <= 1'b0;
			case({down_sync, in_slot})
				2'b10: begin
					case(bitcounter[3:0])
						4'h0: down_data <= 1'b1;		
						4'h1: down_data <= addr_valid;		
						4'h2: down_data <= data_valid;		
						4'h3: down_data <= pcmleft_valid;	
						4'h4: down_data <= pcmright_valid;	
						default: down_data <= 1'b0;
					endcase
				end
				2'b01:
					down_data <= slot_bit;
				default: down_data <= 1'b0;
			endcase
			bitcounter <= bitcounter + 8'd1;
		end
	end
end
assign down_stb = en;
endmodule