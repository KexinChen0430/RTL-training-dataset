module fifo_control_unit
	(
		input 	wire 	clk, 
		input 	wire 	reset, 
		input 	wire 					write_strobe_din, 
		input 	wire 					read_strobe_din, 
		output 	wire 					full_dout, 
		output 	wire 					empty_dout, 
		output 	wire [ADDR_WIDTH-1:0]	write_addr_dout, 
		output 	wire [ADDR_WIDTH-1:0]	read_addr_dout 
    );
	localparam  ADDR_WIDTH = clog2(`BUFFER_DEPTH);
	reg  [ADDR_WIDTH-1:0]	write_ptr_reg;
	reg  [ADDR_WIDTH-1:0]	write_ptr_next;
	reg  [ADDR_WIDTH-1:0]	read_ptr_reg;
	reg  [ADDR_WIDTH-1:0]	read_ptr_next;
	reg 					full_reg;
	reg 					full_next;
	reg 					empty_reg;
	reg 					empty_next;
	assign write_addr_dout 	= write_ptr_reg;
	assign read_addr_dout	= read_ptr_reg;
	assign full_dout		= full_reg;
	assign empty_dout		= empty_reg;
	always @(posedge clk)
		if (reset)
			begin
				full_reg 		<= 1'b0; 
				empty_reg 		<= 1'b1; 
			end
		else
			begin
				full_reg 		<= full_next; 
				empty_reg 		<= empty_next; 
			end
	always @(posedge clk)
		if (reset)
			write_ptr_reg 	<= {ADDR_WIDTH{1'b0}}; 
		else
			write_ptr_reg 	<= write_ptr_next; 
	always @(posedge clk)
		if (reset)
			read_ptr_reg 	<= {ADDR_WIDTH{1'b0}}; 
		else
			read_ptr_reg 	<= read_ptr_next; 
	wire [ADDR_WIDTH-1:0] write_ptr_succ;
	wire [ADDR_WIDTH-1:0] read_ptr_succ;
	assign write_ptr_succ  = (write_ptr_reg == `BUFFER_DEPTH-1) ? {ADDR_WIDTH{1'b0}} : write_ptr_reg + 1'b1;
	assign read_ptr_succ   = (read_ptr_reg  == `BUFFER_DEPTH-1) ? {ADDR_WIDTH{1'b0}} : read_ptr_reg  + 1'b1;
	always @(*)
		begin
			write_ptr_next  = write_ptr_reg;
			read_ptr_next   = read_ptr_reg;
			full_next 		= full_reg;
			empty_next 		= empty_reg;
			case ({write_strobe_din, read_strobe_din})
					2'b01: 
						begin
							if(~empty_reg) 
								begin
									read_ptr_next 		= read_ptr_succ; 
									full_next 			= 1'b0; 
									if (read_ptr_succ 	== write_ptr_reg)
										empty_next 		= 1'b1; 
								end
						end
					2'b10:	
						begin
							if(~full_reg) 
								begin
									write_ptr_next 		= write_ptr_succ; 
									empty_next 			= 1'b0; 
									if (write_ptr_succ 	== read_ptr_reg)
										full_next 		= 1'b1; 
								end
						end
					2'b11: 
						begin
							write_ptr_next = write_ptr_succ;
							read_ptr_next  = read_ptr_succ;
						end
			endcase
		end
	function integer clog2;
		input integer depth;
			for (clog2=0; depth>0; clog2=clog2+1)
				depth = depth >> 1;
	endfunction
endmodule