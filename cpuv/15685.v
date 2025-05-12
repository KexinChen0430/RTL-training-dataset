module -- 
wire 	[31:0]	read_out; 
wire 	[31:0]	write_out; 
wire 	[31:0]	err_out; 
reg		[31:0]	CountRead; 
reg		[31:0]	CountRead_Next; 
reg		[31:0]	CountWrite; 
reg		[31:0]	CountWrite_Next; 
reg		[31:0]	CountError; 
reg		[31:0]	CountError_Next; 
reg		[2:0]	CurrentState; 
reg		[2:0]	NextState; 
localparam	STATE_Initial		= 3'd0,
			STATE_1				= 3'd1,
			STATE_2				= 3'd2,
			STATE_3_Placeholder	= 3'd3,
			STATE_4_Placeholder	= 3'd4,
			STATE_5_Placeholder	= 3'd5,
			STATE_6_Placeholder	= 3'd6,
			STATE_7_Placeholder	= 3'd7;
always@ (posedge clk, posedge reset)
	begin: STATE_TRANS
		if(reset == 1) 
			begin
			CurrentState	<= STATE_Initial;
			CountRead		<= 0;
			CountWrite		<= 0;
			CountError 		<= 0;
			CountRead_Next	<= 0;
			CountWrite_Next	<= 0;
			CountError_Next	<= 0;
			end
		else 
			begin
			CurrentState 	<= NextState;
			CountRead		<= CountRead_Next;
			CountWrite 		<= CountWrite_Next;
			CountError 		<= CountError_Next;
			end
	end
assign read_out = CountRead;
assign write_out = CountWrite;
assign err_out = CountError;
always@ (*)
	begin
	case(CurrentState)
		STATE_Initial: begin
			if(cyc) 
				begin
				if(we) NextState <= STATE_1;
				else NextState <= STATE_2;
				end
			else NextState <= STATE_Initial; 
			if(softreset)	
				begin
				CountWrite_Next <= 0;
				CountRead_Next <= 0;
				CountError_Next <= 0;
				end
			end
		STATE_1: begin
			if(err) 
				begin
				NextState <= STATE_Initial;
				if(!softreset) CountError_Next <= CountError +1;
				else 
					begin
					CountWrite_Next <= 0;
					CountRead_Next 	<= 0;
					CountError_Next <= 1;
					end
				end
			else 
				begin
				if(!cyc)
					begin
					NextState <= STATE_Initial;
					if(!softreset) CountWrite_Next <= CountWrite +1;
					else 
						begin
						CountWrite_Next <= 1;
						CountRead_Next 	<= 0;
						CountError_Next <= 0;
						end
					end
				end
			end
		STATE_2: begin
			if(err) 
				begin
				NextState <= STATE_Initial;
				if(!softreset) CountError_Next <= CountError +1;
				else 
					begin
					CountWrite_Next <= 0;
					CountRead_Next 	<= 0;
					CountError_Next <= 1;
					end
				end
			else 
				begin
				if(!cyc)
					begin
					NextState <= STATE_Initial;
					if(!softreset) CountRead_Next <= CountRead +1;
					else 
						begin
						CountWrite_Next <= 0;
						CountRead_Next 	<= 1;
						CountError_Next <= 0;
						end
					end
				end
			end
		STATE_3_Placeholder: begin
			end
		STATE_4_Placeholder: begin
			end
		STATE_5_Placeholder: begin
			end
		STATE_6_Placeholder: begin
			end
		STATE_7_Placeholder: begin
			end
	endcase
	end
endmodule