module nios_mem_if_ddr2_emif_0_p0_fr_cycle_extender(
	clk,
	reset_n,
	extend_by,
	datain,
	dataout
); 
parameter DATA_WIDTH = ""; 
parameter REG_POST_RESET_HIGH = "false"; 
localparam RATE_MULT = 2; 
localparam REG_STAGES = 2; 
localparam FULL_DATA_WIDTH = DATA_WIDTH*RATE_MULT; 
input	clk; 
input	reset_n; 
input	[1:0] extend_by; 
input	[FULL_DATA_WIDTH-1:0] datain; 
output	[FULL_DATA_WIDTH-1:0] dataout; 
reg [FULL_DATA_WIDTH-1:0] datain_r [REG_STAGES-1:0] ; 
generate
	genvar stage; 
	for (stage = 0; stage < REG_STAGES; stage = stage + 1) 
	begin : stage_gen
		always @(posedge clk or negedge reset_n) 
		begin
			if (~reset_n) 
				if (REG_POST_RESET_HIGH == "true") 
					datain_r[stage] <= {FULL_DATA_WIDTH{1'b1}}; 
				else
					datain_r[stage] <= {FULL_DATA_WIDTH{1'b0}}; 
			else
				datain_r[stage] <= (stage == 0) ? datain : datain_r[stage-1]; 
		end
	end
endgenerate
wire [DATA_WIDTH-1:0] datain_t0 = datain[(DATA_WIDTH*1)-1:(DATA_WIDTH*0)]; 
wire [DATA_WIDTH-1:0] datain_t1 = datain[(DATA_WIDTH*2)-1:(DATA_WIDTH*1)]; 
wire [DATA_WIDTH-1:0] datain_r_t0 = datain_r[0][(DATA_WIDTH*1)-1:(DATA_WIDTH*0)]; 
wire [DATA_WIDTH-1:0] datain_r_t1 = datain_r[0][(DATA_WIDTH*2)-1:(DATA_WIDTH*1)]; 
wire [DATA_WIDTH-1:0] datain_rr_t1 = datain_r[1][(DATA_WIDTH*2)-1:(DATA_WIDTH*1)]; 
assign dataout = (extend_by == 2'b01) ? {datain_t1 | datain_t0, 
                                         datain_t0 | datain_r_t1} : (
                 (extend_by == 2'b10) ? {datain_t1 | datain_t0   | datain_r_t1,
				                         datain_t0 | datain_r_t1 | datain_r_t0} : (
                 (extend_by == 2'b11) ? {datain_t1 | datain_t0   | datain_r_t1 | datain_r_t0,
				                         datain_t0 | datain_r_t1 | datain_r_t0 | datain_rr_t1} : (
                                        {datain_t1, datain_t0} )));
endmodule 