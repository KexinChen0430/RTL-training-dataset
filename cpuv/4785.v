module's internal control clock.
    input rst, 
    input[CNT_WIDTH-1:0] count, 
    input start, 
    input start_tmp, 
    input [DIV_WIDTH-1:0] div, 
    input [COUNT_WIDTH-1:0] counter, 
    output reg clk_sr 
    );