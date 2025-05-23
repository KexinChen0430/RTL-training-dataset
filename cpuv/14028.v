module's undeclared outputs) 
reg [15:0]		data_o; 
reg			done_o; 
reg			valid_o; 
reg [3:0] 		din_len; 
reg [12:0] 		din_data; 
reg 			din_valid; 
always @(cnt_len or cnt_output or cnt_output_enable)
     begin
	din_len = cnt_len;
	din_data = cnt_output;
	din_valid = cnt_output_enable;
     end 
reg 			state, state_next; 
reg [3:0] 		cnt, cnt_next; 
reg [29:0] 		sreg; 
always @(posedge clk or posedge rst)
     begin
	if (rst)
	  sreg <= #1 0; 
	else if (din_valid)
	  sreg <= #1 (sreg << din_len) | din_data; 
     end
always @(posedge clk or posedge rst)
     begin
	if (rst)
	  state <= #1 0; 
	else
	  state <= #1 state_next; 
     end
always @(posedge clk or posedge rst)
     begin
	if (rst)
	  cnt <= #1 0; 
	else
	  cnt <= #1 cnt_next; 
     end
always @(cnt or din_len or din_valid)
     begin
	state_next = 0;
	cnt_next = cnt;
	if (din_valid)
	  {state_next, cnt_next} = cnt + din_len;
     end 
always @(posedge clk)
     begin
	data_o <= #1 sreg >> cnt;
     end
always @(posedge clk)
     valid_o <= #1 state;
always @(posedge clk)
     if (cnt_finish && state == 0 && state == 0)
       done_o <= #1 1'b1;
     else
       done_o <= #1 1'b0;
reg [20:0] ocnt; 
always @(posedge clk or posedge rst)
   begin
      if (rst)
	ocnt <= #1 21'h0; 
      else if (valid_o)
	ocnt <= #1 ocnt + 2'b10; 
   end
endmodule