module's undeclared outputs) 
reg [15:0]		data_o; 
reg			done_o; 
reg			valid_o; 
reg  		cnt; 
always @(posedge clk or posedge rst)
     begin
	if (rst) 
	  cnt <= #1 1'b0; 
	else if (out_valid) 
	  cnt <= #1 cnt + 1'b1; 
     end
always @(posedge clk)
     begin
	if (~cnt && out_valid) 
	  data_o[7:0] <= #1 out_data; 
     end
always @(posedge clk)
     begin
	if (cnt && out_valid) 
	  data_o[15:8] <= #1 out_data; 
     end
always @(posedge clk)
     begin
	if ((&cnt) && out_valid) 
	  valid_o <= #1 1'b1; 
	else
	  valid_o <= #1 1'b0; 
     end
always @(posedge clk)
	done_o <=  #1 out_done; 
endmodule