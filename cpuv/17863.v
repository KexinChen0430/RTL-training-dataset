module RAM128X1S (...); 
    parameter [127:0] INIT = 128'h00000000000000000000000000000000;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;
    output O; 
    input A0, A1, A2, A3, A4, A5, A6;
    input D; 
    input WCLK; 
    input WE; 
endmodule 