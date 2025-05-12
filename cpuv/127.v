module DE0_NANO(
    input CLOCK_50,
    output [7:0] LED,
    input [1:0] KEY,
    output [12:0] DRAM_ADDR,   
    output [1:0] DRAM_BA,      
    output DRAM_CAS_N,         
    output DRAM_CKE,           
    output DRAM_CLK,           
    output DRAM_CS_N,          
    inout [15:0] DRAM_DQ,      
    output [1:0] DRAM_DQM,     
    output DRAM_RAS_N,         
    output DRAM_WE_N,          
    inout [33:0] GPIO,         
    input [1:0] GPIO_IN        
);
endmodule