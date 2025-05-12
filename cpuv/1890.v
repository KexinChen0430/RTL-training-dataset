module mouse_out(
    input wire [9:0] mouse_x, 
    input wire [8:0] mouse_y, 
    input btnm, 
    output reg [4:0]code 
    );