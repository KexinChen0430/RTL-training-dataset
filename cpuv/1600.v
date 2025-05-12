module seven_seg_dev(
	input wire [31:0] disp_num, 
	input wire clk, 
	input wire clr, 
	input wire [1:0]SW, 
	output wire [7:0] SEGMENT, 
	output wire [3:0] AN 
);
	reg [31:0] number; 
	initial number <= 0; 
	display D0(clk, clr, SW[0], number, SEGMENT, AN);
	always @(*) begin
		case (SW)
			2'b01 : number <= { 16'b0, disp_num[15:0] }; 
			2'b11 : number <= { 16'b0, disp_num[31:16] }; 
			default : number <= disp_num; 
		endcase
	end
endmodule