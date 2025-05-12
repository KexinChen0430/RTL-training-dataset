module SPISlaveDelayedResponse#(
		parameter WIDTH = 32,
		parameter DELAY = 32
	) (
		rst_n,
		s_sclk,
		s_mosi,
		s_miso,
		p_mosi,
		p_miso,
		p_valid
	);
	generate
		if((2 * WIDTH) + DELAY - 'h1 >= 4096) begin
			WIDTH_times_2_plus_DELAY_must_be_less_than_4097();
		end
	endgenerate
	input rst_n;
	input s_sclk;
	input s_mosi;
	output s_miso;
	output [WIDTH-1:0] p_mosi;
	input [WIDTH-1:0] p_miso;
	output p_valid;
	reg [WIDTH-1:0] mosi;
	reg [11:0] counter;
	reg [11:0] counterOut;
	assign s_miso = (counter <= WIDTH - 'h1)? p_miso[counter] : 'b0;
	assign p_mosi = mosi;
	assign p_valid = (counter < (DELAY + WIDTH)) || (((2 * WIDTH) + DELAY - 'h1) == counter);
	always @(posedge s_sclk or negedge rst_n) begin
		if(!rst_n) begin
			counter <= (2 * WIDTH) + DELAY - 'h1;
		end
		else begin
			if(counter >= (DELAY + WIDTH)) begin
				mosi[counter - (DELAY + WIDTH)] <= s_mosi;
			end
			counter <= counter? (counter - 'h1) : ((2 * WIDTH) + DELAY - 'h1);
		end
	end
endmodule