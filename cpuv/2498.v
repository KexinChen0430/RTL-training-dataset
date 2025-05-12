module FrameBuffer(
    clka,   
    ena,    
    wea,    
    addra,  
    dina,   
    douta,  
    clkb,   
    web,    
    addrb,  
    dinb,   
    doutb   
);
input clka;          
input ena;           
input [0:0] wea;     
input [13:0] addra;  
input [7:0] dina;    
output [7:0] douta;  
input clkb;          
input [0:0] web;     
input [13:0] addrb;  
input [7:0] dinb;    
output [7:0] doutb;  
endmodule