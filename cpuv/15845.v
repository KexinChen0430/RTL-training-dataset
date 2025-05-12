module erosion_basic_block_0
	(
		input 		clock, 
		input 		resetn, 
		input 		start, 
		input [31:0] 		input_iterations, 
		input 		valid_in, 
		output 		stall_out, 
		output 		valid_out, 
		input 		stall_in, 
		output 		lvb_bb0_cmp6, 
		input [31:0] 		workgroup_size 
	);
wire _entry; 
wire _exit; 
reg [31:0] _num_entry_NO_SHIFT_REG; 
reg [31:0] _num_exit_NO_SHIFT_REG; 
wire [31:0] _num_live; 
assign _entry = ((&valid_in) & ~((|stall_out))); 
assign _exit = ((&valid_out) & ~((|stall_in))); 
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG); 
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0; 
		_num_exit_NO_SHIFT_REG <= 32'h0; 
	end
	else 
	begin
		if (_entry) 
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1); 
		end
		if (_exit) 
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1); 
		end
	end
end
wire merge_node_stall_in_0; 
reg merge_node_valid_out_0_NO_SHIFT_REG; 
wire merge_node_stall_in_1; 
reg merge_node_valid_out_1_NO_SHIFT_REG; 
wire merge_stalled_by_successors; 
reg merge_block_selector_NO_SHIFT_REG; 
reg merge_node_valid_in_staging_reg_NO_SHIFT_REG; 
reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG; 
reg invariant_valid_NO_SHIFT_REG; 
assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG)); 
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG; 
always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in)) 
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0; 
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1; 
	end
	else 
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0; 
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0; 
	end
end
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0; 
	end
	else 
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors)) 
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG)) 
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in; 
			end
		end
		else 
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0; 
		end
	end
end
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0; 
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0; 
	end
	else 
	begin
		if (~(merge_stalled_by_successors)) 
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG; 
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG; 
		end
		else 
		begin
			if (~(merge_node_stall_in_0)) 
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0; 
			end
			if (~(merge_node_stall_in_1)) 
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0; 
			end
		end
	end
end
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0; 
	end
	else 
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG)); 
	end
end
wire local_bb0_cmp6_inputs_ready; 
reg local_bb0_cmp6_wii_reg_NO_SHIFT_REG; 
reg local_bb0_cmp6_valid_out_NO_SHIFT_REG; 
wire local_bb0_cmp6_stall_in; 
wire local_bb0_cmp6_output_regs_ready; 
reg local_bb0_cmp6_NO_SHIFT_REG; 
wire local_bb0_cmp6_causedstall; 
assign local_bb0_cmp6_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG; 
assign local_bb0_cmp6_output_regs_ready = (~(local_bb0_cmp6_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_cmp6_valid_out_NO_SHIFT_REG) | ~(local_bb0_cmp6_stall_in)))); 
assign merge_node_stall_in_0 = (~(local_bb0_cmp6_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp6_output_regs_ready) | ~(local_bb0_cmp6_inputs_ready))); 
assign local_bb0_cmp6_causedstall = (local_bb0_cmp6_inputs_ready && (~(local_bb0_cmp6_output_regs_ready) && !(~(local_bb0_cmp6_output_regs_ready)))); 
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		local_bb0_cmp6_NO_SHIFT_REG <= 'x; 
		local_bb0_cmp6_valid_out_NO_SHIFT_REG <= 1'b0; 
	end
	else 
	begin
		if (start) 
		begin
			local_bb0_cmp6_NO_SHIFT_REG <= 'x; 
			local_bb0_cmp6_valid_out_NO_SHIFT_REG <= 1'b0; 
		end
		else 
		begin
			if (local_bb0_cmp6_output_regs_ready) 
			begin
				local_bb0_cmp6_NO_SHIFT_REG <= (input_iterations == 32'h0); 
				local_bb0_cmp6_valid_out_NO_SHIFT_REG <= local_bb0_cmp6_inputs_ready; 
			end
			else 
			begin
				if (~(local_bb0_cmp6_stall_in)) 
				begin
					local_bb0_cmp6_valid_out_NO_SHIFT_REG <= local_bb0_cmp6_wii_reg_NO_SHIFT_REG; 
				end
			end
		end
	end
end
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b0; 
	end
	else 
	begin
		if (start) 
		begin
			local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b0; 
		end
		else 
		begin
			if (local_bb0_cmp6_inputs_ready) 
			begin
				local_bb0_cmp6_wii_reg_NO_SHIFT_REG <= 1'b1; 
			end
		end
	end
end
wire branch_var__inputs_ready; 
reg branch_node_valid_out_NO_SHIFT_REG; 
wire branch_var__output_regs_ready; 
wire combined_branch_stall_in_signal; 
reg lvb_bb0_cmp6_reg_NO_SHIFT_REG; 
assign branch_var__inputs_ready = (local_bb0_cmp6_valid_out_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG); 
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG)); 
assign local_bb0_cmp6_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready)); 
assign merge_node_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready)); 
assign lvb_bb0_cmp6 = lvb_bb0_cmp6_reg_NO_SHIFT_REG; 
assign valid_out = branch_node_valid_out_NO_SHIFT_REG; 
assign combined_branch_stall_in_signal = stall_in; 
always @(posedge clock or negedge resetn)
begin
	if (~(resetn)) 
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0; 
		lvb_bb0_cmp6_reg_NO_SHIFT_REG <= 'x; 
	end
	else 
	begin
		if (branch_var__output_regs_ready) 
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready; 
			lvb_bb0_cmp6_reg_NO_SHIFT_REG <= local_bb0_cmp6_NO_SHIFT_REG; 
		end
		else 
		begin
			if (~(combined_branch_stall_in_signal)) 
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0; 
			end
		end
	end
end
endmodule 