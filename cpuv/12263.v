module uart_rx#( 
	parameter integer WIDTH = 12 
	)
	(
	input PCLK, 
	input RESET, 
	input RX_I, 
	input [11:0] WORK_FR, 
	output reg [7:0] DATA_RX_O, 
	output reg PARITY_RX, 
	output READY 
	);
localparam [3:0] RX_IDLE   	 = 4'b0000, 
	   	 RX_DETECT_START = 4'b0001, 
	   	 RX_TAKE_DATA    = 4'b0010, 
	   	 RX_TAKE_PARITY  = 4'b0100, 
	   	 RX_HIGH_DETECT  = 4'b1000; 
reg [3:0] state_rx; 
reg [3:0] next_state_rx; 
reg [WIDTH-1:0] COUNTER; 
reg [3:0] DATA_COUNTER; 
reg AUX; 
assign READY  = (state_rx == RX_HIGH_DETECT & COUNTER == 12'd2)?1'b1:1'b0;
always@(*)
begin
	next_state_rx = state_rx; 
	case(state_rx) 
	endcase
end
always@(posedge PCLK)
begin
	if(RESET) 
	begin
		state_rx <= RX_IDLE;
		COUNTER<= {WIDTH{1'b0}};
		DATA_COUNTER<= 4'd0;
		DATA_RX_O<=8'd0;
		AUX<= 1'b1;
	end
	else 
	begin
		state_rx <= next_state_rx;
		case(state_rx) 
		endcase
	end
end
endmodule