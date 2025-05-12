module RAM256X1S (...); 
    parameter [255:0] INIT = 256'h0; 
    parameter [0:0] IS_WCLK_INVERTED = 1'b0; 
    output O; 
    input [7:0] A; 
    input D; 
    input WCLK; 
    input WE; 
endmodule 