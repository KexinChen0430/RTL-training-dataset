module
parameter MAX = 19999;
reg dir;
reg dir_;
reg en;
reg [14:0] in_;
reg [31:0] counter;
wire [31:0] divflag;
reg [31:0] PWMctl_clk;
initial PWMctl_clk = MAX;
initial in_ = MAX;
assign divflag = PWMctl_clk - in_;
assign dir_out = dir;
assign en_out = en;
always @(posedge clk)begin
	if(rst)begin
		in_ <= 19999;
		dir_ <= 0;
	end
	else if(0 < para_in && para_in < PWMctl_clk)begin
		in_ <= para_in;
		dir_ <= dir_in;
	end
	else
		in_ <= MAX;
end
always @(posedge clk)begin
		if(rst)begin
			dir <= 0;
			en <= 0;
		end
		else if(divflag > counter)begin
			dir <= dir_;
			en <= 1;
		end
		else begin
			en <= 0;
		end
	end
always @(posedge clk)begin
		if(rst)begin
			counter <= 0;
		end
		else if(PWMctl_clk == counter)
			counter <= 0;
		else
			counter <= counter + 1;
	end
endmodule