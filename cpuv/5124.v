module blk_mem_gen_1(
    clka,   
    wea,    
    addra,  
    dina,   
    clkb,   
    enb,    
    addrb,  
    doutb   
);
input clka;           
input [0:0] wea;      
input [11:0] addra;   
input [7:0] dina;     
input clkb;           
input enb;            
input [9:0] addrb;    
output [31:0] doutb;  
endmodule