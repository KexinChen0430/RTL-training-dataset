module output_control_unit
	(
		input wire clk, 
		input wire reset, 
		input  wire credit_in_din, 
		input  wire done_strobe_din, 
		output wire zero_credits_dout, 
		output wire [2:0] output_selector_dout 
	);
	localparam IDLE 	= 2'b00; 
	localparam REQUEST 	= 2'b01; 
	localparam ACTIVE 	= 2'b10; 
	localparam LOAD		= 1'b1; 
	localparam DEC		= 1'b0; 
	localparam CREDITS 	 = `BUFFER_DEPTH/5; 
	localparam CRT_WIDTH = clog2(CREDITS); 
	reg [CRT_WIDTH-1:0] credit_reg; 
	reg [CRT_WIDTH-1:0] credit_next; 
	always @(posedge clk)
		if (reset)
			credit_reg <= CREDITS; 
		else
			credit_reg <= credit_next; 
	always @(*)
		begin
			credit_next = credit_reg; 
			case ({credit_in_din, credit_sub})
				2'b01: credit_next = credit_reg - 1'b1; 
				2'b10: credit_next = credit_reg + 1'b1; 
			endcase
		end
	assign credit_sub = (state_reg == REQUEST & state_next == ACTIVE) ? 1'b1 : 1'b0;
	assign zero_credits = ~(|credit_reg); 
	assign zero_credits_dout = zero_credits; 
	reg [2:0] flit_counter_reg; 
	reg [2:0] flit_counter_next; 
	wire flit_counter_load; 
	wire flit_counter_sub; 
	always @(posedge clk)
		if (reset)
			flit_counter_reg <= 3'b000; 
		else
			flit_counter_reg <= flit_counter_next; 
	always @(*)
		begin
			flit_counter_next <= flit_counter_reg; 
			case ({flit_counter_load, flit_counter_sub})
				2'b10: flit_counter_next <= `DATA_FLITS + 1; 
				2'b01: flit_counter_next <= flit_counter_reg - 1'b1; 
			endcase
		end
	assign output_selector_dout = (state_next == ACTIVE || state_reg == ACTIVE) ? flit_counter_reg : 3'b000;
	reg [1:0] state_reg; 
	reg [1:0] state_next; 
	always @(posedge clk)
		if (reset)
			state_reg <= IDLE; 
		else
			state_reg <= state_next; 
	always @(*)
		begin
			state_next <= state_reg; 
			case (state_reg)
				IDLE:
					if (done_strobe_din)
						state_next <= REQUEST; 
				REQUEST:
					if (~zero_credits)
						state_next <= ACTIVE; 
				ACTIVE:
					if (flit_counter_reg == {3{1'b0}})
						state_next <= IDLE; 
			endcase
		end
	assign flit_counter_load = (state_reg == IDLE & state_next == REQUEST) ? 1'b1 : 1'b0;
	assign flit_counter_sub = (state_next == ACTIVE) ? 1'b1 : 1'b0;
	function integer clog2;
		input integer depth;
		for (clog2=0; depth>0; clog2=clog2+1)
			depth = depth >> 1;
	endfunction
	reg [8*7:0] state_reg_dbg; 
	always @(*)
		case (state_reg)
			IDLE	:	state_reg_dbg = " IDLE  "; 
			REQUEST	:	state_reg_dbg = "REQUEST"; 
			ACTIVE	:	state_reg_dbg = " ACTIVE"; 
			default	: 	state_reg_dbg = "ERROR"; 
		endcase
endmodule