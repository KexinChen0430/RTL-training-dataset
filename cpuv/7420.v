module L1_Cache_Controller 
(
	input	clk, 
	input	rst, 
	input	cache_cs, 
	input	cache_we, 
	input	cache_hit, 
	input	cache_dirty, 
	output	sram_cs, 
	output	sram_we, 
	output	stall, 
	output	mem_cs, 
	output	mem_we, 
	output 	mem_wb 
);
	wire	ext_mem_ack	= CPU.ext_mem_ack; 
	reg		mem_enable; 
	reg		mem_write; 
	reg		r_cache_we; 
	reg		write_back; 
	assign	mem_cs		= mem_enable; 
	assign	mem_we		= mem_write; 
	assign 	mem_wb		= write_back; 
	wire	write_hit; 
	assign	sram_cs 	= cache_cs || cache_we; 
	assign	sram_we 	= r_cache_we || write_hit; 
	assign 	write_hit 	= cache_hit && cache_we; 
	assign  stall 		= ~cache_hit && (cache_cs || cache_we) ; 
	parameter STATE_IDLE 		= 2'd0, 
			  STATE_COMPARE_TAG	= 2'd1, 
			  STATE_ALLOCATE	= 2'd2, 
			  STATE_WRITE_BACK	= 2'd3; 
	reg		[1:0]	state; 
	always @ (posedge clk or negedge rst) begin 
		if(~rst) 
		begin
			state <= STATE_IDLE; 
			mem_enable <= 1'b0; 
			mem_write <= 1'b0; 
			r_cache_we   <= 1'b0; 
			write_back <= 1'b0; 
		end
		else 
		begin
			case(state) 
				STATE_IDLE: 
				begin
					if(cache_cs || cache_we) 
					begin
						state <= STATE_COMPARE_TAG; 
					end
					else 
					begin
						state <= STATE_IDLE; 
					end
				end
				STATE_COMPARE_TAG: 
				begin
					if(cache_hit) 
					begin
						mem_enable <= 1'b0; 
						mem_write <= 1'b0; 
						r_cache_we   <= 1'b0; 
						write_back <= 1'b0; 
						state <= STATE_IDLE; 
					end
					else if(cache_dirty && ~cache_hit) 
					begin
						mem_enable <= 1'b1; 
						mem_write <= 1'b1; 
						r_cache_we   <= 1'b0; 
						write_back <= 1'b1; 
						state<= STATE_WRITE_BACK; 
					end
					else if(~cache_dirty && ~cache_hit) 
					begin
						mem_enable <= 1'b1; 
						mem_write <= 1'b0; 
						r_cache_we   <= 1'b1; 
						write_back <= 1'b0; 
						state <= STATE_ALLOCATE; 
					end
					else 
					begin
						mem_enable <= 1'b0; 
						mem_write <= 1'b0; 
						r_cache_we   <= 1'b0; 
						write_back <= 1'b0; 
						state <= STATE_IDLE; 
					end
				end
				STATE_ALLOCATE: 
				begin
					if(ext_mem_ack) 
					begin
						state <= STATE_COMPARE_TAG; 
					end
					else 
					begin
						state <= STATE_ALLOCATE; 
					end
				end
				STATE_WRITE_BACK: 
				begin
					if(ext_mem_ack) 
					begin
						mem_enable <= 1'b1; 
						mem_write <= 1'b0; 
						r_cache_we   <= 1'b1; 
						write_back <= 1'b0; 
						state <= STATE_ALLOCATE; 
					end
					else 
					begin
						state <= STATE_WRITE_BACK; 
					end
				end
			endcase 
		end 
	end 
endmodule 