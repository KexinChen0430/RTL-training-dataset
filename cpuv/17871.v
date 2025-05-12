module RAM32X1D (...); 
    parameter [31:0] INIT = 32'h00000000; 
    parameter [0:0] IS_WCLK_INVERTED = 1'b0; 
    output DPO, SPO; 
    input A0, A1, A2, A3, A4; 
    input D; 
    input DPRA0, DPRA1, DPRA2, DPRA3, DPRA4; 
    input WCLK; 
    input WE; 
endmodule 