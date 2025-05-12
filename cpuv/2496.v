module BIOS_ROM(
    clka,   
    ena,    
    wea,    
    addra,  
    dina,   
    douta   
);
input clka;        
input ena;         
input [0:0] wea;   
input [11:0] addra;
input [7:0] dina;  
output [7:0] douta;
endmodule 