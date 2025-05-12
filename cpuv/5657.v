module arbiter ( 
	input clk, 
	input reset, 
	output [31:0] request_data, 
	output stall, 
	input [31:0] fetch_addr, 
	input fetch_request, 
	output fetch_data_valid, 
	input [31:0] dmem_addr, 
	input [31:0] dmem_write_data, 
	input [3:0] dmem_write_mask, 
	input dmem_request, 
	input dmem_request_type, 
	output dmem_data_valid, 
	output reg [31:0] mem_addr, 
	output [3:0] mem_mask, 
	output mem_enable, 
	output reg mem_cmd, 
	input [31:0] mem_data, 
	output [31:0] mem_wdata, 
	input mem_valid 
);
wire requests_pending = fetch_request | dmem_request; 
reg fetch_satisfied; 
reg memory_satisfied; 
localparam S_IDLE      = 3'd0; 
localparam S_SVC_FETCH = 3'd1; 
localparam S_SVC_MEM_R = 3'd2; 
localparam S_SVC_MEM_W = 3'd3; 
reg [2:0] state; 
reg [2:0] next_state; 
always @ (posedge clk) begin
	if (reset) begin
		state <= S_IDLE; 
	end else begin
		state <= next_state; 
	end
end
always @ (posedge clk) begin
	if (reset) begin
		fetch_satisfied  <= 1; 
	end else if (state == S_IDLE && next_state != S_IDLE) begin
		fetch_satisfied  <= (fetch_request ? 0 : 1); 
	end else if (state == S_SVC_FETCH && mem_valid) begin
		fetch_satisfied  <= 1; 
	end
	if (reset) begin
		memory_satisfied <= 1; 
	end else if (state == S_IDLE && next_state != S_IDLE) begin
		memory_satisfied <= (dmem_request ? 0 : 1); 
	end else if (state == S_SVC_MEM_R && mem_valid) begin
		memory_satisfied <= 1; 
	end
end
always @ (*) begin
	case (state)
		S_IDLE:
			if (requests_pending)
				if (fetch_request)
					next_state = S_SVC_FETCH; 
				else if (dmem_request)
					if (dmem_request_type == `MEM_REQ_WRITE)
						next_state = S_SVC_MEM_W; 
					else
						next_state = S_SVC_MEM_R; 
				else
					next_state = S_IDLE; 
			else
				next_state = S_IDLE; 
		S_SVC_FETCH:
			if (!fetch_satisfied)
				next_state = S_SVC_FETCH; 
			else if (dmem_request)
				if (dmem_request_type == `MEM_REQ_WRITE)
					next_state = S_SVC_MEM_W; 
				else
					next_state = S_SVC_MEM_R; 
			else
				next_state = S_IDLE; 
		S_SVC_MEM_R:
			if (!memory_satisfied)
				next_state = S_SVC_MEM_R; 
			else
				next_state = S_IDLE; 
		S_SVC_MEM_W:
			next_state = S_IDLE; 
		default:
			next_state = S_IDLE; 
	endcase
end
always @ (*) begin
	case (state)
		S_SVC_FETCH:
			mem_addr = fetch_addr; 
		S_SVC_MEM_R, S_SVC_MEM_W:
			mem_addr = dmem_addr; 
		default:
			mem_addr = 0; 
	endcase
end
assign stall = (next_state != S_IDLE); 
assign fetch_data_valid = (state == S_SVC_FETCH & mem_valid); 
assign dmem_data_valid = (state == S_SVC_MEM_R & mem_valid); 
assign request_data = mem_data; 
assign mem_wdata = dmem_write_data; 
assign mem_enable = (state == S_SVC_FETCH && !fetch_satisfied) ||
                    (state == S_SVC_MEM_R && !memory_satisfied) ||
                    (state == S_SVC_MEM_W); 
assign mem_mask = dmem_write_mask; 
always @ (*) begin
	case (state)
		S_SVC_FETCH: mem_cmd = `MEM_CMD_READ; 
		S_SVC_MEM_R: mem_cmd = `MEM_CMD_READ; 
		S_SVC_MEM_W: mem_cmd = `MEM_CMD_WRITE; 
		default: mem_cmd = 0; 
	endcase
end
endmodule