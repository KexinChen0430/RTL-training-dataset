module test_engine_nic_input_control_unit
	(
		input wire clk,                           
		input wire reset,                         
		input wire header_field_din,              
		input wire busy_engine_din,               
		input wire zero_credits_din,              
		output wire transfer2pe_strobe_dout,      
		output wire write_strobe_dout,            
		output wire [`DATA_FLITS:0] register_enable_dout 
	);
	localparam IDLE 	= 2'b00; 
	localparam CAPTURE 	= 2'b01; 
	localparam WAIT 	= 2'b10; 
			reg [1:0]	state_reg;      
			reg [1:0]	state_next;     
			always @(posedge clk)
				if (reset)
					state_reg <= IDLE; 
				else
					state_reg <= state_next; 
			always @(*)
				begin
					state_next = state_reg; 
					case (state_reg)
						IDLE:
							if (header_field_din)
								state_next = CAPTURE; 
						CAPTURE:
							if ((register_enable_reg == {`DATA_FLITS+1{1'b0}}) & (~busy_engine_din) & (~zero_credits_din))
								state_next = IDLE; 
							else if ((register_enable_reg == {`DATA_FLITS+1{1'b0}}) & (busy_engine_din | zero_credits_din))
								state_next = WAIT; 
						WAIT:
							if (~busy_engine_din & ~zero_credits_din)
								state_next = IDLE; 
					endcase 
				end
			assign transfer2pe_strobe_dout	= ((state_reg == CAPTURE | state_reg == WAIT) & (state_next == IDLE)) 	? 1'b1 : 1'b0;
			assign write_strobe_dout		= (state_next == CAPTURE) 												? 1'b1 : 1'b0;
		reg  [`DATA_FLITS:0] register_enable_reg; 
		wire [`DATA_FLITS:0] register_enable_next; 
		always @(posedge clk)
			if (reset)
				register_enable_reg <= {{`DATA_FLITS{1'b0}}, 1'b1}; 
			else
				register_enable_reg <= register_enable_next; 
		assign register_enable_next = 	(state_next == CAPTURE) ? register_enable_reg << 1 		: 
										(state_next == IDLE)	? {{`DATA_FLITS{1'b0}}, 1'b1}	: 
										register_enable_reg; 
		assign register_enable_dout = register_enable_reg;
	reg [7*8:0] state_reg_dbg;
	always @(*)
		case (state_reg)
			IDLE: 		state_reg_dbg 	= " IDLE  "; 
			WAIT: 		state_reg_dbg 	= " WAIT  "; 
			CAPTURE:	state_reg_dbg 	= "CAPTURE"; 
			default : 	state_reg_dbg 	= " ERROR "; 
		endcase
endmodule