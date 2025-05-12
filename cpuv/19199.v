module */ 
assign dout = daddr == 32'h00000000 ? mask : {status,1'b1}; 
wire [31:1] external_interrupts = {28'b0, i_button, i_uart, i_timer}; 
assign int = state; 
wire next_state = !state && ((mask[31:1] & status) != 0) && mask[0] ? 1 : state && int_ack ? 0 : state; 
wire [31:0] mask_v = drw[0] && de && daddr == 32'h00000000 ? din : mask; 
wire [31:0] next_mask = state ? {mask_v[31:1],1'b0} : mask_v; 
wire [31:1] status_v = drw[0] && de && daddr == 32'h00000004 ? din[31:1] : status; 
wire [31:1] next_status = external_interrupts | status_v; 
always @(negedge clk) begin 
	if (!rst) begin 
		status <= next_status; 
		mask   <= next_mask; 
		state  <= next_state; 
	end else if (rst) begin 
		status <= 0; 
		mask   <= 0; 
		state  <= 0; 
	end
end
endmodule