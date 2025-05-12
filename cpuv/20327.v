module profibus_telegram_length (
	input clk,               
	input n_reset,           
	input [7:0] in_byte,     
	input new_byte,          
	output reg length_valid, 
	output reg [7:0] length, 
	output reg error,        
);
	localparam STATE_START	= 0; 
	localparam STATE_LE		= 1; 
	localparam STATE_LER	= 2; 
	localparam SD1			= 8'h10; 
	localparam SD2			= 8'h68; 
	localparam SD3			= 8'hA2; 
	localparam SD4			= 8'hDC; 
	localparam SC			= 8'hE5; 
	reg [7:0] byte_le; 
	reg [1:0] state;   
	initial begin
		length_valid <= 0;
		length <= 0;
		error <= 0;
		byte_le <= 0;
		state <= STATE_START;
	end
	always @(posedge clk) begin
		if (n_reset) begin 
			case (state) 
				STATE_START: begin 
					if (new_byte) begin 
						if (in_byte == SD1) begin
							length <= 6;
							error <= 0;
							length_valid <= 1;
						end else if (in_byte == SD2) begin
							length <= 0;
							error <= 0;
							length_valid <= 0;
							state <= STATE_LE; 
						end else if (in_byte == SD3) begin
							length <= 14;
							error <= 0;
							length_valid <= 1;
						end else if (in_byte == SD4) begin
							length <= 3;
							error <= 0;
							length_valid <= 1;
						end else if (in_byte == SC) begin
							length <= 1;
							error <= 0;
							length_valid <= 1;
						end else begin
							length <= 0;
							error <= 1;
							length_valid <= 0;
						end
					end
				end
				STATE_LE: begin 
					if (new_byte) begin 
						if (in_byte >= 4 && in_byte <= 249) begin
							byte_le <= in_byte;
							state <= STATE_LER; 
						end else begin
							error <= 1;
							length_valid <= 0;
							state <= STATE_START; 
						end
					end
				end
				STATE_LER: begin 
					if (new_byte) begin 
						if (in_byte == byte_le) begin
							length <= byte_le + 6; 
							error <= 0;
							length_valid <= 1;
							state <= STATE_START; 
						end else begin
							error <= 1;
							length_valid <= 0;
							state <= STATE_START; 
						end
					end
				end
				default: begin 
					length_valid <= 0;
					length <= 0;
					error <= 0;
					byte_le <= 0;
					state <= STATE_START;
				end
			endcase
		end else begin
			length_valid <= 0;
			length <= 0;
			error <= 0;
			byte_le <= 0;
			state <= STATE_START;
		end
	end
endmodule