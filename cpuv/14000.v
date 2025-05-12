module comb_utx_sm(load, shiftregin, baudce, cur_utx_state, bitcounter, nextbit, bitcounterce, busy, done_int, serialout, next_utx_state);
	input load;
	input shiftregin;
	input baudce;
	input [1:0] cur_utx_state;
	input [3:0] bitcounter;
	output reg nextbit;
	output reg bitcounterce;
	output reg busy;
	output reg done_int;
	output reg serialout;
	output reg [1:0] next_utx_state;
	always @(*) begin
		busy <= 1;
		done_int <= 0;
		nextbit <= 0;
		serialout <= 1;
		bitcounterce <= baudce;
		case(cur_utx_state)
			`IDLE:
				if(load) begin
					next_utx_state <= `SENDSTART;
					serialout <= 0; 
				end else begin
					busy <= 0; 
					bitcounterce <= 0; 
					next_utx_state <= `IDLE; 
				end
			`SENDSTART:
				if(baudce) begin
					next_utx_state <= `SENDBITS;
					serialout <= shiftregin;
				end else begin
					serialout <= 0;
					next_utx_state <= `SENDSTART;
				end
			`SENDBITS:
				begin
					if(bitcounter == 9) begin
						next_utx_state <= `SENDSTOP;
						serialout <= 1; 
					end else begin
						serialout <= shiftregin;
						next_utx_state <= `SENDBITS;
						nextbit <= baudce;
					end
				end
			`SENDSTOP:
				if(baudce) begin
					next_utx_state <= `IDLE;
					done_int <= 1;
					nextbit <= baudce;
				end else begin
					next_utx_state <= `SENDSTOP;
				end
			default:
				begin
					bitcounterce <= 1'bx;
					serialout <= 1'bx;
					busy <= 1'bx;
					next_utx_state <= 2'bxx;
				end
		endcase
	end
endmodule