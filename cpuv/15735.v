module rs232_recv #(
	parameter integer HALF_PERIOD = 5 
) (
	input  clk, 
	input  RX, 
	output reg LED1, 
	output reg LED2, 
	output reg LED3, 
	output reg LED4, 
	output reg LED5  
);
	reg [7:0] buffer; 
	reg buffer_valid; 
	reg [$clog2(3*HALF_PERIOD):0] cycle_cnt; 
	reg [3:0] bit_cnt = 0; 
	reg recv = 0; 
	initial begin
		LED1 = 1; 
		LED2 = 0; 
		LED3 = 1; 
		LED4 = 0; 
		LED5 = 1; 
	end
	always @(posedge clk) begin
		buffer_valid <= 0; 
		if (!recv) begin 
			if (!RX) begin 
				cycle_cnt <= HALF_PERIOD; 
				bit_cnt <= 0; 
				recv <= 1; 
			end
		end else begin 
			if (cycle_cnt == 2*HALF_PERIOD) begin 
				cycle_cnt <= 0; 
				bit_cnt <= bit_cnt + 1; 
				if (bit_cnt == 9) begin 
					buffer_valid <= 1; 
					recv <= 0; 
				end else begin 
					buffer <= {RX, buffer[7:1]}; 
				end
			end else begin 
				cycle_cnt <= cycle_cnt + 1; 
			end
		end
	end
	always @(posedge clk) begin
		if (buffer_valid) begin 
			if (buffer == "1") LED1 <= !LED1; 
			if (buffer == "2") LED2 <= !LED2; 
			if (buffer == "3") LED3 <= !LED3; 
			if (buffer == "4") LED4 <= !LED4; 
			if (buffer == "5") LED5 <= !LED5; 
		end
	end
endmodule