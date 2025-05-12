module display(
    input clk, rst, mode, 
    input [31:0]disp_num, 
    output reg [7:0]seg,  
    output reg [3:0]anode 
);