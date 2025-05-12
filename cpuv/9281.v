module for mfspr/mtspr instructions 
input           lr_we; 
input           ctr_we; 
output	[31:0]  lr; 
output	[31:0]  ctr; 
input   [31:0]  spr_dat_i; 
output          flush_branch; 
output          npc_branch_valid; 
output  [29:0]  npc_branch; 
reg     [31:0]  lr; 
reg     [31:0]  ctr; 
reg             crb_value; 
reg     [29:0]  branch_target; 
wire    [31:0]  lr_new; 
wire    [31:0]  ctr_new; 
wire    [31:0]  ctr_minus_one; 
assign AA_bit = bpu_uops[4]; 
assign LK_bit = bpu_uops[3]; 
always @(bpu_uops or branch_addrofs or cia or lr or ctr or AA_bit) begin 
    branch_target = 30'd0; 
    case (bpu_uops[2:0]) 
        `BPUOP_NOP: branch_target = 30'd0; 
        `BPUOP_BIMM: begin 
            if(AA_bit)
                branch_target = branch_addrofs;
            else
                branch_target = branch_addrofs + cia;
        end
        `BPUOP_BCIMM: begin 
            if(AA_bit)
                branch_target = branch_addrofs;
            else
                branch_target = branch_addrofs + cia;
        end
        `BPUOP_BCLR: branch_target = lr[31:2]; 
        `BPUOP_BCCTR: branch_target = ctr[31:2]; 
    endcase
end
always @(cr or bi_field) begin 
    case (bi_field) 
        5'b00000:   crb_value = cr[31]; 
        5'b00001:   crb_value = cr[30]; 
        5'b00010:   crb_value = cr[29]; 
        5'b00011:   crb_value = cr[28]; 
        5'b00100:   crb_value = cr[27]; 
        5'b00101:   crb_value = cr[26]; 
        5'b00110:   crb_value = cr[25]; 
        5'b00111:   crb_value = cr[24]; 
        5'b01000:   crb_value = cr[23]; 
        5'b01001:   crb_value = cr[22]; 
        5'b01010:   crb_value = cr[21]; 
        5'b01011:   crb_value = cr[20]; 
        5'b01100:   crb_value = cr[19]; 
        5'b01101:   crb_value = cr[18]; 
        5'b01110:   crb_value = cr[17]; 
        5'b01111:   crb_value = cr[16]; 
        5'b10000:   crb_value = cr[15]; 
        5'b10001:   crb_value = cr[14]; 
        5'b10010:   crb_value = cr[13]; 
        5'b10011:   crb_value = cr[12]; 
        5'b10100:   crb_value = cr[11]; 
        5'b10101:   crb_value = cr[10]; 
        5'b10110:   crb_value = cr[9]; 
        5'b10111:   crb_value = cr[8]; 
        5'b11000:   crb_value = cr[7]; 
        5'b11001:   crb_value = cr[6]; 
        5'b11010:   crb_value = cr[5]; 
        5'b11011:   crb_value = cr[4]; 
        5'b11100:   crb_value = cr[3]; 
        5'b11101:   crb_value = cr[2]; 
        5'b11110:   crb_value = cr[1]; 
        5'b11111:   crb_value = cr[0]; 
    endcase
end
assign cr_test = bo_field[4] | (!bo_field[4] & (crb_value == bo_field[3])); 
assign ctr_test = bo_field[2] | (!bo_field[2] & ((|ctr_minus_one) == !bo_field[1])); 
assign branch_taken = cr_test & ctr_test; 
assign lr_new = LK_bit ? {snia, 2'b00} : lr; 
always @(posedge clk or posedge rst) begin 
	if (rst)
		lr <= #1 32'b0; 
	else if(lr_we)
		lr <= #1 spr_dat_i; 
    else
        lr <= #1 lr_new; 
end
assign ctr_dec = bo_field[2]; 
assign ctr_minus_one = ctr - 1'b1; 
assign ctr_new = ctr_dec ? ctr_minus_one : ctr; 
always @(posedge clk or posedge rst) begin 
	if (rst)
		ctr <= #1 32'b0; 
	else if(ctr_we)
		ctr <= #1 spr_dat_i; 
    else
        ctr <= #1 ctr_new; 
end
assign flush_branch = (bpu_uops[2:0] == `BPUOP_BIMM) | ((|bpu_uops[2:0]) & branch_taken); 
assign npc_branch_valid = (|bpu_uops[2:0]) & flush_branch; 
assign npc_branch = branch_target; 
endmodule 