module mb2cpx_sm (
	cpx_fsl_s_read,
	cpx_shift_out,
	cpx_spc_data_rdy_cx2,
	rclk,
	reset_l,
	fsl_cpx_s_exists,
	fsl_cpx_s_control,
	atomic_txn
	);
    parameter CPX_GEAR_RATIO = (((`CPX_WIDTH+3-1)/`FSL_D_WIDTH)+1);
    parameter CPX_FSL_EXTRA_BITS  = (`FSL_D_WIDTH * CPX_GEAR_RATIO) -
				    (`PCX_WIDTH+3);
    parameter [2:0] CPX_FIRST_COUNT = CPX_GEAR_RATIO - 2;
    parameter pCPX_IDLE    = 0,
	      pCPX_SHIFT   = 1,
	      pCPX_AT_WAIT = 2;
    parameter CPX_IDLE    = 3'b001,
	      CPX_SHIFT   = 3'b010,
	      CPX_AT_WAIT = 3'b100;
    output cpx_fsl_s_read;
    output cpx_shift_out;
    output cpx_spc_data_rdy_cx2;
    input rclk;
    input reset_l;
    input fsl_cpx_s_exists;
    input fsl_cpx_s_control;
    input atomic_txn;
    reg  cpx_fsl_s_read;
    reg  cpx_shift_out;
    wire cpx_spc_data_rdy_cx2;
    reg  [2:0] curr_state;
    reg  [2:0] next_state;
    reg  [2:0] curr_count;
    reg  [2:0] next_count;
    reg        atomic_first;
    reg        atomic_second;
    reg        next_atomic_first;
    reg        next_atomic_second;
    reg        next_shift_out;
    reg        atomic_second_d1;
    reg        atomic_second_d2;
    reg	       cpx_shift_out_d1;
    always @ (posedge rclk) begin  
	if (!reset_l) begin
	    curr_state <= CPX_IDLE;
	    curr_count <= 3'b000;
	    atomic_first <= 1'b0;
	    atomic_second <= 1'b0;
	    cpx_shift_out <= 1'b0;
	end
	else begin
	    curr_state <= next_state;
	    curr_count <= next_count;
	    atomic_first <= next_atomic_first;
	    atomic_second <= next_atomic_second;
	    cpx_shift_out <= next_shift_out;
	end
    end
    always @(posedge rclk) begin
	atomic_second_d1 <= atomic_second;
	atomic_second_d2 <= atomic_second_d1;
	cpx_shift_out_d1 <= cpx_shift_out;
    end
    always @ (curr_state or fsl_cpx_s_exists or fsl_cpx_s_control or
	    curr_count or atomic_txn or atomic_first or atomic_second) begin
	case (1)
	    curr_state[pCPX_IDLE] : begin
		next_atomic_second = 1'b0;
		next_shift_out = 1'b0;
		if (fsl_cpx_s_exists && fsl_cpx_s_control) begin
		    next_state = CPX_SHIFT;
		    next_count = CPX_FIRST_COUNT;
		    next_atomic_first = atomic_txn;
		    cpx_fsl_s_read = 1'b1;
		end
		else if (fsl_cpx_s_exists && !fsl_cpx_s_control) begin
		    next_state = CPX_IDLE;
		    next_count = 3'b000;
		    next_atomic_first = 1'b0;
		    cpx_fsl_s_read = 1'b1;
		end
		else begin
		    next_state = CPX_IDLE;
		    next_count = 3'b000;
		    next_atomic_first = 1'b0;
		    cpx_fsl_s_read = 1'b0;
		end
	    end
	    curr_state[pCPX_SHIFT] : begin
		if (fsl_cpx_s_exists && curr_count == 3'b000) begin
		    if (atomic_first) begin
			next_state = CPX_AT_WAIT;
			next_count = curr_count;
			next_atomic_first = 1'b0;
			next_atomic_second = atomic_first;
			cpx_fsl_s_read = 1'b1;
			next_shift_out = 1'b1;
		    end
		    else begin
			next_state = CPX_IDLE;
			next_count = CPX_FIRST_COUNT;
			next_atomic_first = 1'b0;
			next_atomic_second = 1'b0;
			cpx_fsl_s_read = 1'b1;
			next_shift_out = 1'b1;
		    end
		end
		else if (fsl_cpx_s_exists) begin
		    next_state = CPX_SHIFT;
		    next_count = curr_count - 3'b001;
		    next_atomic_first = atomic_first;
		    next_atomic_second = atomic_second;
		    cpx_fsl_s_read = 1'b1;
		    next_shift_out = 1'b0;
		end
		else begin
		    next_state = CPX_SHIFT;
		    next_count = curr_count;
		    next_atomic_first = atomic_first;
		    next_atomic_second = atomic_second;
		    cpx_fsl_s_read = 1'b0;
		    next_shift_out = 1'b0;
		end
	    end
	    curr_state[pCPX_AT_WAIT] : begin
		next_atomic_first = atomic_first;
		next_atomic_second = atomic_second;
		next_shift_out = 1'b0;
		if (fsl_cpx_s_exists && fsl_cpx_s_control) begin
		    next_state = CPX_SHIFT;
		    next_count = CPX_FIRST_COUNT;
		    cpx_fsl_s_read = 1'b1;
		end
		else if (fsl_cpx_s_exists && !fsl_cpx_s_control) begin
		    next_state = CPX_AT_WAIT;
		    next_count = 3'b000;
		    cpx_fsl_s_read = 1'b1;
		end
		else begin
		    next_state = CPX_AT_WAIT;
		    next_count = 3'b000;
		    cpx_fsl_s_read = 1'b0;
		end
	    end
	    default : begin
		next_state = CPX_IDLE;
		next_count = 3'b000;
		next_atomic_first = 1'b0;
		next_atomic_second = 1'b0;
		cpx_fsl_s_read = 1'b0;
		next_shift_out = 1'b0;
	    end
	endcase
    end
    assign cpx_spc_data_rdy_cx2 = (!atomic_second && !atomic_second_d2 &&
	    				cpx_shift_out_d1) ||
    				  (atomic_second_d1 && cpx_shift_out);
endmodule