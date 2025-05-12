module RAM32X1S (...); 
    parameter [31:0] INIT = 32'h00000000; 
    parameter [0:0] IS_WCLK_INVERTED = 1'b0; 
    output O; 
    input A0, A1, A2, A3, A4; 
    input D; 
    input WCLK; 
    input WE; 
endmodule 