module timer (
  clk, reset, wrenb, wraddr, config_data,
  update_timers, fsm_start_timer, fsm_clear_timer, fsm_stop_timer,
  timer_elapsed);
input clk, reset; 
input wrenb, wraddr; 
input [31:0] config_data; 
input update_timers; 
input fsm_start_timer, fsm_clear_timer, fsm_stop_timer; 
output timer_elapsed; 
reg [35:0] timer, next_timer; 
reg [35:0] timer_limit, next_timer_limit; 
reg timer_active, next_timer_active; 
reg timer_elapsed, next_timer_elapsed; 
initial
begin
  timer = 36'h0; 
  timer_active = 1'b0; 
  timer_elapsed = 1'b0; 
  timer_limit = 36'h0; 
end
always @ (posedge clk)
begin
  timer = next_timer; 
  timer_active = next_timer_active; 
  timer_elapsed = next_timer_elapsed; 
  timer_limit = next_timer_limit; 
end
always @*
begin
  next_timer = (timer_elapsed) ? 36'h0 : timer; 
  next_timer_active = timer_active; 
  next_timer_elapsed = timer_elapsed; 
  next_timer_limit = timer_limit; 
  if (timer_active)
    begin
      next_timer = timer + 1'b1; 
      if (timer >= timer_limit)
	begin
	  next_timer_elapsed = 1'b1; 
	  next_timer_active = 1'b0; 
	end
    end
  if (update_timers)
    begin
      if (fsm_start_timer) next_timer_active = 1'b1; 
      if (fsm_clear_timer) begin next_timer = 0; next_timer_elapsed = 1'b0; end 
      if (fsm_stop_timer) next_timer_active = 1'b0; 
    end
  if (wrenb)
    case (wraddr)
      1'b0 : next_timer_limit[31:0] = config_data; 
      1'b1 : next_timer_limit[35:32] = config_data[3:0]; 
    endcase
  if (reset)
    begin
      next_timer = 0; 
      next_timer_active = 0; 
      next_timer_elapsed = 0; 
    end
end
endmodule