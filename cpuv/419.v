module dispatch_general_register(
		input wire iCLOCK,          
		input wire inRESET,         
		input wire iRESET_SYNC,     
		input wire iWR_VALID,       
		input wire [4:0] iWR_ADDR,  
		input wire [31:0] iWR_DATA, 
		input wire [4:0] iRD0_ADDR,     
		output wire [31:0] oRD0_DATA,   
		input wire [4:0] iRD1_ADDR,     
		output wire [31:0] oRD1_DATA,   
		output wire [31:0] oDEBUG_REG_OUT_GR0,
		output wire [31:0] oDEBUG_REG_OUT_GR31
	);
	integer i;
	reg [31:0] b_ram0[0:31]; 
	reg [31:0] b_ram1[0:31]; 
	always@(posedge iCLOCK or negedge inRESET) begin
		if(!inRESET) begin
			for(i = 0; i < 32; i = i + 1) begin
				b_ram0[i] <= 32'h0;
			end
		end else if(iRESET_SYNC) begin
			for(i = 0; i < 32; i = i + 1) begin
				b_ram0[i] <= 32'h0;
			end
		end else begin
			if(iWR_VALID) begin
				b_ram0[iWR_ADDR] <= iWR_DATA;
			end
		end
	end 
	assign oRD0_DATA = b_ram0[iRD0_ADDR];
	assign oRD1_DATA = b_ram1[iRD1_ADDR];
	`ifdef MIST1032ISA_STANDARD_DEBUGGER
		assign oDEBUG_REG_OUT_GR0 = b_ram0[0];
		assign oDEBUG_REG_OUT_GR31 = b_ram0[31];
	`else
		assign oDEBUG_REG_OUT_GR0 = 32'h0;
		assign oDEBUG_REG_OUT_GR31 = 32'h0;
	`endif
endmodule