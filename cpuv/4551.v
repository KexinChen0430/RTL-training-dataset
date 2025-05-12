module will work in master or slave mode for receiving or transmitting data.
reg tog_a = 1'b0, tog_b = 1'b0, toggle = 1'b0;
reg [1:0] ctr = 2'b00;
reg synch = 1'b0;
always @(posedge clk) begin
	tog_a <= toggle_en;
	tog_b <= tog_a;
	toggle <= tog_a & ~tog_b;
	if (toggle) begin
		ctr <= (ctr == cnt_m) ? 2'b00 : ctr + 1'b1;
		if (synch_en) begin
			if (ctr == cnt_m) synch <= 1'b1;
			else if (ctr == cnt_n) synch <= 1'b0;
			else synch <= synch;
		end else synch <= 1'b0;
	end
	synchroStatus <= (opMode) ? synch : syncInOut;
end
assign syncInOut = (opMode) ? synch : 1'bz;
endmodule