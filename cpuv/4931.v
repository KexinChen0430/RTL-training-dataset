module disk02 (
    address, 
    clock,   
    data,    
    wren,    
    q);      
    input   [10:0] address; 
    input     clock;        
    input   [7:0]  data;    
    input     wren;         
    output  [7:0]  q;       
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri1     clock;
    `ifndef ALTERA_RESERVED_QIS
    `endif
endmodule