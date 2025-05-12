module counter(
    input CP,
    input CLR_,
    input M,
    input [7:0] RS,
    input LD_,
    output reg [7:0] Q,
    output QCC_
    );
	reg TEMP;
	initial begin
		Q = 8'b00000000;
	end
	always @(posedge CP)
	begin
		TEMP = ((~Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7] & ~M) | (Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & M)) & CLR_ & LD_;
	end
	always @(posedge CP or negedge CLR_ or negedge LD_)
	begin
		if (CP == 1'b1)
		begin
			if (M == 1'b1)
			begin
				Q = Q+1'b1;
			end
			else
			begin
				Q = Q-1'b1;
			end
		end
		if (CLR_ == 1'b0)
		begin
			Q = 8'b00000000;
		end
		if (LD_ == 1'b0)
		begin
			Q = RS;
		end
	end
	assign QCC_ = TEMP & CP;
endmodule