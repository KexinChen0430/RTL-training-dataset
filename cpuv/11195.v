module's undeclared outputs) 
reg [31:0] timer_count_running; 
reg timer_interrupt; 
wire timer_count_done = timer_enable & (timer_count_running >= (timer_count-1)); 
always @(posedge clk) 
   if (reset) begin 
      timer_count_running <= 16'b0;
   end else if (timer_count_done) begin 
      timer_count_running <= 16'b0;
   end else if (timer_enable) begin 
      timer_count_running <= timer_count_running +1;
   end else begin 
      timer_count_running <= 16'b0;
   end
always @(posedge clk) 
   if (reset) begin 
      timer_interrupt <= 1'b0;
   end else if (timer_interrupt_clear) begin 
      timer_interrupt <= 1'b0;
   end else if (timer_enable) begin 
      timer_interrupt <= timer_count_done;
   end else begin 
      timer_interrupt <= 1'b0;
   end
endmodule 