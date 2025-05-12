module adder_n
	#(
		parameter	N	=	32
	)(
		input	[N-1:0]			iDATA_0,
		input	[N-1:0]			iDATA_1,
		input	[4:0]			iADDER_CMD,
		output	[N-1:0]			oDATA,
		output					oSF,
		output					oOF,
		output					oCF,
		output					oPF,
		output					oZF
	);
						func_pri_op0				=	{1'b0, func_data0};
						func_pri_op1				=	{1'b0, func_data1};
						func_pri_out				=	{33{1'b0}};
						func_adder_execution		=	{37{1'h0}};
					end
			endcase
		end
	endfunction
endmodule