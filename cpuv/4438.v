module VOICE_ROM_INIT(
    clka,   
    wea,    
    addra,  
    dina,   
    clkb,   
    addrb,  
    doutb   
);
input clka;          
input [0:0] wea;     
input [5:0] addra;   
input [15:0] dina;   
input clkb;          
input [5:0] addrb;   
output [15:0] doutb; 
endmodule 