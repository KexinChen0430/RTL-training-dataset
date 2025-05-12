module testFSM(clkFSM, resetFSM, initDone, writeDone, nextString, data, writeStart); 
	input clkFSM; 
	input resetFSM; 
	input initDone; 
	input writeDone; 
	input	nextString; 
	output [7:0]	data; 
	output			writeStart; 
	reg [7:0]		data; 
	reg 		 		writeStart; 
	reg [5:0] 		state,next_state; 
	`define idle 	     6'b000000
	`define data1	     6'b000001
	`define wait1	     6'b100001
	`define data2	     6'b000010
	`define wait2	     6'b100010
	`define data3	     6'b000011
	`define wait3	     6'b100011
	`define data4	     6'b000100
	`define wait4	     6'b100100
	`define data5	     6'b000101
	`define wait5	     6'b100101
	`define data6	     6'b000110
	`define wait6	     6'b100110
	`define data7	     6'b000111
	`define wait7	     6'b100111
	`define data8	     6'b001000
	`define wait8	     6'b101000
	`define waitClear   6'b011111
	`define finish      6'b111111
	always @ (clkFSM or state or initDone or writeDone or nextString)
		begin
			next_state <= `idle; 
			data = 8'b00000000; 
			writeStart = 'b0; 
			case(state) 
				`idle : 
					begin
						if(initDone == 1'b1) 
							next_state <= `data1; 
						else
							next_state <= `idle; 
					end
				`data1 : 
					begin
						data = 8'b00110001;		
						writeStart = 1'b1; 
						next_state <= `wait1; 
					end
				`wait1 : 
					begin
						data = 8'b00110001; 
						if(writeDone == 1'b1) 
							next_state <= `data2; 
						else
							next_state <= `wait1; 
					end
			endcase
		end
	always @ (posedge clkFSM)
		begin
			if (resetFSM) 
				begin
					state <= `idle; 
				end
			else 
				begin
					state <= next_state; 
				end
		end 
endmodule 