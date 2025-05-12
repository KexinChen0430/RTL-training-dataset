module display(
    input clk, 
    input [15:0]disp_num, 
    output reg [6:0]seg, 
    output reg [3:0]anode 
);