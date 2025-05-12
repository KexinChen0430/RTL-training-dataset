module ICE_IO_DLY(
    PACKAGEPIN,         
    LATCHINPUTVALUE,    
    CLOCKENABLE,        
    INPUTCLK,           
    OUTPUTCLK,          
    OUTPUTENABLE,       
    DOUT1,              
    DOUT0,              
    DIN1,               
    DIN0,               
    SCLK,               
    SDI,                
    CRSEL,              
    SDO                 
);
input CLOCKENABLE;      
input CRSEL;            
output DIN0;            
output DIN1;            
input DOUT0;            
input DOUT1;            
input INPUTCLK;         
input LATCHINPUTVALUE;  
input OUTPUTCLK;        
input OUTPUTENABLE;     
inout PACKAGEPIN;       
input SCLK;             
input SDI;              
output SDO;             
endmodule