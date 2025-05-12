module cycloneii_crcblock
(
    clk,        
    shiftnld,   
    ldsrc,      
    crcerror,   
    regout      
);
input clk;         
input shiftnld;    
input ldsrc;       
output crcerror;   
output regout;     
parameter oscillator_divider = 1;  
parameter lpm_type = "cycloneii_crcblock";  
endmodule