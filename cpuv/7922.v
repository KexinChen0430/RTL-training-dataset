module jt12_testdata
#(parameter rand_wait=0) 
(
	input				rst, 
	input				clk, 
	output	reg			cs_n, 
	output	reg			wr_n, 
	output	reg [1:0]	addr, 
	output	reg	[7:0]	dout, 
	input		[7:0]	din, 
	output	reg			prog_done 
);
	reg [16:0] cfg[0:65535]; 
	initial begin
		`include "inputs.vh" 
	end
	reg [15:0] data_cnt; 
	reg [ 3:0] state, next; 
	reg [15:0] waitcnt; 
	localparam WAIT_FREE=0, WR_ADDR=1, WR_VAL=2, DONE=3, WRITE=4, 
		BLANK=5, WAIT_CNT=6;
	localparam BUSY_TIMEOUT=500; 
    integer rnd_count, timeout; 
	always @(posedge clk or posedge rst) begin 
		if( rst ) begin 
			data_cnt 	<= 0; 
			prog_done	<= 0; 
			next 		<= WR_ADDR; 
			state		<= WAIT_FREE; 
			addr		<= 2'b0; 
			wr_n		<= 1'b1; 
			dout		<= 8'h0; 
            rnd_count	<= 0; 
			waitcnt		<= 16'h0; 
			timeout		<= BUSY_TIMEOUT; 
		end
		else begin 
			case( state ) 
				BLANK:	begin 
                	if( rnd_count>0 ) 
                    	rnd_count <= rnd_count -1; 
                    else begin 
                    	state <= WAIT_FREE; 
                    	timeout <= BUSY_TIMEOUT; 
                    end
                    wr_n <= 1'b1; 
                end
				WAIT_FREE: begin 
					{ cs_n, wr_n } <= 2'b01; 
					timeout <= timeout-1; 
					if(timeout==0) begin 
						$display("ERROR: timeout while waiting for BUSY\n"); 
						$finish; 
					end
					if( !din[7] ) begin 
						case( cfg[data_cnt][15:8] ) 
							8'h0: state <= DONE; 
							8'h1: begin 
								waitcnt <= { cfg[data_cnt][7:0], 8'h0 }; 
								state <= WAIT_CNT; 
							end
							8'h3: if( (din[1:0]&cfg[data_cnt][1:0])!=2'd0 ) state<=next; 
							default: state <= next; 
						endcase
					end
				end
				WAIT_CNT: begin 
						if( waitcnt==16'd0 ) begin 
							data_cnt <= data_cnt + 1'b1; 
							timeout <= BUSY_TIMEOUT; 
							state <= WAIT_FREE; 
						end
						else waitcnt <= waitcnt-1'b1; 
					end
				WRITE: begin 
					{ cs_n, wr_n } <= 2'b00; 
                    rnd_count <= rand_wait ? ($urandom%100) : 0; 
					state<= BLANK; 
				end
				WR_ADDR: begin 
					addr <= { cfg[data_cnt][16], 1'b0 }; 
					dout <= cfg[data_cnt][15:8]; 
					next <= WR_VAL; 
					state<= WRITE; 
				end
				WR_VAL: begin 
					addr[0] <= 1'b1; 
					dout 	<= cfg[data_cnt][7:0]; 
					state	<= WRITE; 
					if( &data_cnt == 1'b1 ) begin 
                    	$display("data_cnt overflow! jt12_testdata.v"); 
						next      <= DONE; 
					end
					else begin 
						data_cnt <= data_cnt + 1'b1; 
						next <= WR_ADDR; 
					end
				end
				DONE: prog_done <= 1'b1; 
			endcase
		end
	end
endmodule