module ddr3_data_exercise_sm (rst, clk, cmd_rdy, datain_rdy, read_data, read_data_valid, wl_err, cmd_valid, cmd, cmd_burst_cnt, addr, write_data, data_mask);
input wire rst; 
input wire clk; 
input wire cmd_rdy; 
input wire datain_rdy; 
input wire [63:0] read_data; 
input wire read_data_valid; 
input wire wl_err; 
output reg cmd_valid; 
output reg [3:0] cmd; 
output wire [4:0] cmd_burst_cnt; 
output reg [25:0] addr; 
output reg [63:0] write_data; 
output wire [7:0] data_mask; 
assign cmd_burst_cnt = 5'b00001; 
assign data_mask = 8'b00000000; 
parameter NADA = 4'b0000, 
			READ = 4'b0001, 
			WRITE = 4'b0010, 
			READA = 4'b0011, 
			WRITEA = 4'b0100, 
			PDOWN_ENT = 4'b0101, 
			LOAD_MR = 4'b0110, 
			SEL_REF_ENT = 4'b1000, 
			SEL_REF_EXIT = 4'b1001, 
			PDOWN_EXIT = 4'b1011, 
			ZQ_LNG = 4'b1100, 
			ZQ_SHRT = 4'b1101; 
parameter ADDRESS1 = 26'h0001400, 
			ADDRESS2 = 26'h0001500; 
parameter DATA1_1 = 64'h1AAA2AAA3AAA4AAA, 
			DATA1_2 = 64'hE555D555C555B555, 
			DATA2_1 = 64'h0123456789ABCDEF, 
			DATA2_2 = 64'hFEDCBA9876543210; 
parameter S_IDLE = 5'b00000, 
			S_PDOWN_ENT = 5'b00001, 
			S_PDOWN_EXIT = 5'b00010, 
			S_WRITE_ADDR1 = 5'b00011, 
			S_WRITE_WAIT1 = 5'b00100, 
			S_WRITE_DATA1_1 = 5'b00101, 
			S_WRITE_DATA1_2 = 5'b00110, 
			S_WRITE_ADDR2 = 5'b00111, 
			S_WRITE_WAIT2 = 5'b01000, 
			S_WRITE_DATA2_1 = 5'b01001, 
			S_WRITE_DATA2_2 = 5'b01010, 
			S_READ1 = 5'b01011, 
			S_READ2 = 5'b01100, 
			S_READ_WAIT1 = 5'b01101, 
			S_READ_WAIT2 = 5'b01110, 
			S_READ_WAIT3 = 5'b01111, 
			S_READ_WAIT4 = 5'b10000, 
			S_HALT = 5'b10001; 
reg [4:0] state, next; 
always @(posedge clk or posedge rst)
		if (rst) state <= S_IDLE; 
		else state <= next; 
always @(state or cmd_rdy or datain_rdy or read_data_valid) begin
		next = 'bx; 
		case (state)
		endcase
	end
always @(posedge clk or posedge rst)
		if (rst) begin
			cmd_valid <= 1'b0; 
			cmd <= NADA; 
			addr <= 26'h0000000; 
			write_data <= 64'h0000000000000000; 
		end
		else begin
			cmd_valid <= 1'b0; 
			cmd <= NADA; 
		case (next)
		endcase
	end
endmodule