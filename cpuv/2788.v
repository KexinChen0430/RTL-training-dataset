module DDRDLLA(
    input CLK,        
    input RST,        
    input UDDCNTLN,   
    input FREEZE,     
    output LOCK,      
    output DDRDEL,    
    output DCNTL7,    
    output DCNTL6,    
    output DCNTL5,    
    output DCNTL4,    
    output DCNTL3,    
    output DCNTL2,    
    output DCNTL1,    
    output DCNTL0     
);
    parameter FORCE_MAX_DELAY = "NO"; 
    parameter GSR = "ENABLED";        
endmodule