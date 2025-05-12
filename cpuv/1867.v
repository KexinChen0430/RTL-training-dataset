module bch_encode #(
	parameter [`BCH_PARAM_SZ-1:0] P = `BCH_SANE,
	parameter BITS = 1,
	parameter PIPELINE_STAGES = 0
) (
	input clk,
	input start,				
	input ce,				
	input [BITS-1:0] data_in,		
	output [BITS-1:0] data_out,		
	output first,				
	output reg last = 0,			
	output data_bits,			
	output ecc_bits,			
	output ready				
);
	`include "bch.vh"
	`include "bch_encode.vh"
	localparam M = `BCH_M(P);
	localparam TCQ = 1;
	localparam ENC = encoder_poly(0);
	localparam DATA_CYCLES = PIPELINE_STAGES + (`BCH_DATA_BITS(P) + BITS - 1) / BITS;
	localparam ECC_CYCLES = (`BCH_ECC_BITS(P) + BITS - 1) / BITS;
	localparam CODE_CYCLES = DATA_CYCLES + ECC_CYCLES;
	localparam signed SHIFT = BITS - `BCH_ECC_BITS(P);
	localparam SWITCH = lfsr_count(M, DATA_CYCLES - 2);
	localparam DONE = lfsr_count(M, CODE_CYCLES - 3);
	localparam REM = `BCH_DATA_BITS(P) % BITS;
	localparam RUNT = BITS - REM;
	if (PIPELINE_STAGES > 1)
		encode_only_supports_1_pipeline_stage u_eos1ps();
	reg [`BCH_ECC_BITS(P)-1:0] lfsr = 0;
	wire [`BCH_ECC_BITS(P)-1:0] lfsr_first;
	wire [`BCH_ECC_BITS(P)-1:0] lfsr_next;
	wire [BITS-1:0] data_in_pipelined;
	wire [BITS-1:0] output_mask;
	wire [BITS-1:0] shifted_in;
	wire [M-1:0] count;
	reg load_lfsr = 0;
	reg busy = 0;
	reg start_last = 0;
	if (CODE_CYCLES < 3)
		assign count = 0;
	else
		lfsr_counter #(M) u_counter(
			.clk(clk),
			.reset(ce && start),
			.ce(ce && busy),
			.count(count)
		);
	generate
		if (REM) begin
			reg [RUNT-1:0] runt = 0;
			assign shifted_in = (data_in << RUNT) | (start ? 0 : runt);
			always @(posedge clk)
				if (ce)
					runt <= #TCQ data_in << REM;
		end else
			assign shifted_in = data_in;
	endgenerate
	wire [BITS-1:0] lfsr_input;
	assign lfsr_input = SHIFT > 0 ? (lfsr << SHIFT) : (lfsr >> -SHIFT);
	if (`CONFIG_PIPELINE_LFSR) begin
		wire [`BCH_ECC_BITS(P)-1:0] in_enc;
		wire [`BCH_ECC_BITS(P)-1:0] in_enc_pipelined;
		wire [`BCH_ECC_BITS(P)-1:0] lfsr_enc;
		lfsr_term #(`BCH_ECC_BITS(P), ENC, BITS) u_in_terms(
			.in(shifted_in),
			.out(in_enc)
		);
		pipeline_ce #(PIPELINE_STAGES > 0) u_enc_pipeline [`BCH_ECC_BITS(P)-1:0] (
			.clk(clk),
			.ce(ce),
			.i(in_enc),
			.o(in_enc_pipelined)
		);
		lfsr_term #(`BCH_ECC_BITS(P), ENC, BITS) u_lfsr_terms(
			.in(lfsr_input),
			.out(lfsr_enc)
		);
		assign lfsr_first = in_enc_pipelined;
		assign lfsr_next = (lfsr << BITS) ^ lfsr_enc ^ in_enc_pipelined;
	end else begin
		wire [BITS-1:0] shifted_in_pipelined;
		pipeline_ce #(PIPELINE_STAGES > 0) u_enc_pipeline [BITS-1:0] (
			.clk(clk),
			.ce(ce),
			.i(shifted_in),
			.o(shifted_in_pipelined)
		);
		function [`BCH_ECC_BITS(P)-1:0] lfsr_rep;
			input [`BCH_ECC_BITS(P)-1:0] prev;
			input [BITS-1:0] in;
			reg [`BCH_ECC_BITS(P)-1:0] ret;
			integer i;
		begin
			ret = prev;
			for (i = BITS - 1; i >= 0; i = i - 1)
				ret = {ret[`BCH_ECC_BITS(P)-2:0], 1'b0} ^
					({`BCH_ECC_BITS(P){ret[`BCH_ECC_BITS(P)-1] ^ in[i]}} & ENC);
			lfsr_rep = ret;
		end
		endfunction
		assign lfsr_first = lfsr_rep(0, shifted_in_pipelined);
		assign lfsr_next = lfsr_rep(lfsr, shifted_in_pipelined);
	end
	pipeline_ce #(PIPELINE_STAGES) u_data_pipeline [BITS-1:0] (
		.clk(clk),
		.ce(ce),
		.i(data_in),
		.o(data_in_pipelined)
	);
	assign first = PIPELINE_STAGES ? start_last : (start && !busy);
	assign data_bits = (start && !PIPELINE_STAGES) || load_lfsr;
	assign ecc_bits = (busy || last) && !data_bits;
	if (REM)
		assign output_mask = last ? {{RUNT{1'b1}}, {REM{1'b0}}} : {BITS{1'b1}};
	else
		assign output_mask = {BITS{1'b1}};
	assign data_out = data_bits ? data_in_pipelined : (lfsr_input & output_mask);
	assign ready = !busy;
	always @(posedge clk) begin
		if (ce) begin
			start_last <= #TCQ start && !busy;
			if (start) begin
				last <= #TCQ CODE_CYCLES < 3; 
				busy <= #TCQ 1;
			end else if (count == DONE && busy) begin
				last <= #TCQ busy;
				busy <= #TCQ !PIPELINE_STAGES;
			end else if (last) begin
				last <= #TCQ 0;
				busy <= #TCQ 0;
			end
			if (start)
				load_lfsr <= #TCQ DATA_CYCLES > 1;
			else if (count == SWITCH)
				load_lfsr <= #TCQ 1'b0;
			if (start)
				lfsr <= #TCQ PIPELINE_STAGES ? 0 : lfsr_first;
			else if (load_lfsr)
				lfsr <= #TCQ lfsr_next;
			else if (busy)
				lfsr <= #TCQ lfsr << BITS;
		end
	end
endmodule