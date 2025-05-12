module RPCv3RouterCrossbar
#(
	parameter CORE_DATA_WIDTH 				= 32, 
	parameter CHILD_IS_TRUNK				= 1'b0, 
	parameter CHILD_COUNT 					= 4, 
	parameter CHILD_DATA_WIDTH				= 32'h20202020, 
	parameter NEIGHBOR_PRESENT 				= {4'b1111}, 
	parameter NEIGHBOR_DATA_WIDTH 			= 32'h20202020, 
	parameter X_POS 						= 4'h0, 
	parameter Y_POS 						= 4'h0  
)
(
	input wire												clk, 
	output reg[(CHILD_COUNT+4)-1 : 0]						rx_fifo_rd		= 0, 
	input wire[(CHILD_COUNT+4)-1 : 0]						rx_fifo_empty, 
	input wire[(CHILD_COUNT+4)*CORE_DATA_WIDTH-1 : 0]		rx_fifo_dout, 
	input wire[(CHILD_COUNT+4)*6-1 : 0]						rx_fifo_rsize, 
	output reg[3:0]											leds			= 0 
);
	localparam TOTAL_PORTS		= 4 + CHILD_COUNT; 
	localparam MESSAGE_WORDS 	= 128 / CORE_DATA_WIDTH; 
	localparam BASE_ADDR		= {X_POS, Y_POS, 8'h00}; 
	reg[16*TOTAL_PORTS - 1 : 0]	rx_port_dst_addr; 
	integer i;
	always @(*) begin
		for(i=0; i<TOTAL_PORTS; i=i+1)
			rx_port_dst_addr[i*16 +: 16]		<= rx_fifo_dout[( (i+1)*CORE_DATA_WIDTH - 1) -: 16]; 
	end
	localparam RX_STATE_IDLE		= 3'h0; 
	localparam RX_STATE_RD_ADDR		= 3'h1; 
	localparam RX_STATE_ADDR_VALID	= 3'h2; 
	localparam RX_STATE_PACKET_BODY	= 3'h3; 
	reg[2:0]				rx_port_state[TOTAL_PORTS-1:0]; 
	initial begin
		for(i=0; i<TOTAL_PORTS; i=i+1)
			rx_port_state[i]		<= RX_STATE_IDLE; 
	end
	reg[TOTAL_PORTS-1:0]	rx_addr_valid; 
	always @(*) begin
		for(i=0; i<TOTAL_PORTS; i=i+1)
			rx_addr_valid[i]	<= (rx_port_state[i] == RX_STATE_ADDR_VALID); 
	end
	always @(posedge clk) begin
		rx_fifo_rd		<= 0; 
		for(i=0; i<TOTAL_PORTS; i=i+1) begin
			case(rx_port_state[i])
				RX_STATE_IDLE: begin
					if(rx_fifo_rsize[i*6 +: 6] >= MESSAGE_WORDS) begin
						rx_fifo_rd[i]		<= 1; 
						rx_port_state[i]	<= RX_STATE_RD_ADDR; 
					end
				end	
				RX_STATE_RD_ADDR: begin
					rx_port_state[i]		<= RX_STATE_ADDR_VALID; 
				end	
				RX_STATE_ADDR_VALID: begin
				end	
				RX_STATE_PACKET_BODY: begin
				end	
			endcase
		end
	end
endmodule