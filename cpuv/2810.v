module background_painter(
	 input wire [9:0] hpos, 
    input wire [8:0] vpos, 
	 input wire [11:0] code, 
	 input wire [32:0] resultado, 
	 input wire [4:0] res_out_code, 
	 output reg [2:0] res_in_row, 
	 output reg [3:0] num_salida, 
	 output reg [3:0] out_row, 
	 output reg [1:0] row, 
	 output reg [2:0] column, 
	 output reg [7:0] rgb 
    );