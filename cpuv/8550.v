module Snake
(
	input clk, 
	input rst, 
	input[15:0] point, 
	input left_press, 
	input right_press, 
	input up_press, 
	input down_press, 
	output reg [1:0]snake, 
	input [9:0]x_pos, 
	input [9:0]y_pos, 
	output [5:0]head_x, 
	output [5:0]head_y, 
	input add_cube, 
	input [1:0]game_status, 
	output reg [6:0]cube_num, 
	output reg hit_body, 
	output reg hit_wall, 
	input die_flash 
);
	localparam UP = 2'b00; 
	localparam DOWN = 2'b01; 
	localparam LEFT = 2'b10; 
	localparam RIGHT = 2'b11; 
	localparam NONE = 2'b00; 
	localparam HEAD = 2'b01; 
	localparam BODY = 2'b10; 
	localparam WALL = 2'b11; 
    localparam RESTART = 2'b00; 
	localparam PLAY = 2'b10; 
	reg[31:0]cnt; 
	reg[31:0] cnt_lv1 = 32'd12_500_000; 
	reg[31:0] cnt_lv2 = 32'd62_500_00; 
	wire[1:0]direct; 
	reg [1:0]direct_r; 
	assign direct = direct_r; 
	reg[1:0]direct_next; 
	reg change_to_left; 
	reg change_to_right; 
	reg change_to_up; 
	reg change_to_down; 
	reg [5:0]cube_x[15:0]; 
	reg [5:0]cube_y[15:0]; 
	reg [15:0]is_exist; 
	reg addcube_state; 
	assign head_x = cube_x[0]; 
	assign head_y = cube_y[0]; 
	always @(posedge clk or negedge rst) begin 
		if(!rst)
			direct_r <= RIGHT; 
		else if(game_status == RESTART)
		    direct_r <= RIGHT;
		else
			direct_r <= direct_next;
	end
	always @(posedge clk or negedge rst) begin 
		if(!rst) begin
			is_exist <= 16'd7;
			cube_num <= 3;
			addcube_state <= 0;
		end
		else if (game_status == RESTART) begin
		      is_exist <= 16'd7;
              cube_num <= 3;
              addcube_state <= 0;
         end
		else begin
			case(addcube_state) 
				0:begin
					if(add_cube) begin
						cube_num <= cube_num + 1;
						is_exist[cube_num] <= 1;
						addcube_state <= 1;
					end
				end
				1:begin
					if(!add_cube)
						addcube_state <= 0;
				end
			endcase
		end
	end
	reg[3:0]lox;
	reg[3:0]loy;
	always @(x_pos or y_pos ) begin 
		if(x_pos >= 0 && x_pos < 640 && y_pos >= 0 && y_pos < 480) begin
			if(x_pos[9:4] == 0 | y_pos[9:4] == 0 | x_pos[9:4] == 39 | y_pos[9:4] == 29)
				snake = WALL; 
			else if(x_pos[9:4] == cube_x[0] && y_pos[9:4] == cube_y[0] && is_exist[0] == 1)
				snake = (die_flash == 1) ? HEAD : NONE; 
			else if
				((x_pos[9:4] == cube_x[1] && y_pos[9:4] == cube_y[1] && is_exist[1] == 1)|
				 snake = (die_flash == 1) ? BODY : NONE;
			else snake = NONE;
		end
	end
endmodule