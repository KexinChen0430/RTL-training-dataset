module flag_rename_management #(
		parameter ENTRY_ID = 4'h0
	)(
input wire iCLOCK,
input wire inRESET,
input wire iREMOVE_VALID,
input wire [63:0] iCOMMIT_VECTOR,
input wire iREGIST_0_VALID,
input wire [3:0] iREGIST_0_FLAGAS_REGNAME,
input wire [5:0] iREGIST_0_COMMIT_TAG,
input wire iREGIST_1_VALID,
input wire [3:0] iREGIST_1_FLAGAS_REGNAME,
input wire [5:0] iREGIST_1_COMMIT_TAG,
input wire iALU1_VALID,
input wire [5:0] iALU1_COMMIT_TAG,
input wire [4:0] iALU1_FLAGS,
input wire iALU2_VALID,
input wire [5:0] iALU2_COMMIT_TAG,
input wire [4:0] iALU2_FLAGS,
input wire iFREELIST_REGIST_VALID,
output wire oINFO_FREELIST_REQ,
output wire oINFO_FLAGS_VALID,
output wire [4:0] oINFO_FLAGS
);
reg [2:0] b_state;
reg b_reset;
reg b_freelist_req;
reg b_flag_valid;
reg [5:0] b_commit_tag;
reg [4:0] b_flags;
wire [5:0] w_commit_wait_check_vector;
assign w_commit_wait_check_vector = b_commit_tag+6'h1;
always@(posedge iCLOCK or negedge inRESET)begin
	if(!inRESET)begin
		b_state <= 3'h0;
		b_reset <= 1'b0;
		b_freelist_req <= 1'b0;
		b_flag_valid <= 1'b0;
		b_commit_tag <= 6'h00;
		b_flags <= 5'h00;
	end
	else if((iREMOVE_VALID && b_state != 3'h3) || b_reset)begin
		b_state <= 3'h0;
		b_reset <= 1'b0;
		b_freelist_req <= 1'b0;
		b_flag_valid <= 1'b0;
		b_commit_tag <= 6'h00;
		b_flags <= 5'h00;
	end
	else begin
		case(b_state)
			3'h0 :		
				begin
					if(iFREELIST_REGIST_VALID)begin
						b_state <= 3'h1;
						b_freelist_req <= 1'b0;
					end
					else begin
						b_freelist_req <= 1'b1;
						b_flag_valid <= 1'b0;
					end
				end
			3'h1 : 		
				begin
					if(iREGIST_0_VALID && ENTRY_ID == iREGIST_0_FLAGAS_REGNAME)begin
						b_state <= 3'h2;
						b_commit_tag <= iREGIST_0_COMMIT_TAG;
					end
					else if(iREGIST_1_VALID && ENTRY_ID == iREGIST_1_FLAGAS_REGNAME)begin
						b_state <= 3'h2;
						b_commit_tag <= iREGIST_1_COMMIT_TAG;
					end
				end
			3'h2 : 		
				begin
					if(iALU1_VALID && b_commit_tag == iALU1_COMMIT_TAG)begin
						b_state <= 3'h3;
						b_flags <= iALU1_FLAGS;
						b_flag_valid <= 1'b1;
					end
					else if(iALU2_VALID && b_commit_tag == iALU2_COMMIT_TAG)begin
						b_state <= 3'h3;
						b_flags <= iALU2_FLAGS;
						b_flag_valid <= 1'b1;
					end
				end
			3'h3:		
				begin
					if(iCOMMIT_VECTOR[w_commit_wait_check_vector])begin
						b_flag_valid <= 1'b0;
						b_reset <= 1'b1;
					end
				end
		endcase
	end
end 
assign oINFO_FREELIST_REQ = b_freelist_req;
assign oINFO_FLAGS_VALID = b_flag_valid;
assign oINFO_FLAGS = b_flags;
endmodule