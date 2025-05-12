module qram32 (
    address,  
    byteena,  
    clock,    
    data,     
    wren,     
    q         
);
    input   [13:0]  address;  
    input   [3:0]   byteena;  
    input           clock;    
    input   [31:0]  data;     
    input           wren;     
    output  [31:0]  q;        
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri1    [3:0]  byteena;  
    tri1            clock;    
    `ifndef ALTERA_RESERVED_QIS
    `endif
endmodule