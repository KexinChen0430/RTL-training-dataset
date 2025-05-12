module DAS_RF (
    clock,      
    data,       
    rdaddress,  
    wraddress,  
    wren,       
    q           
);
    input   clock;      
    input   [15:0] data;      
    input   [13:0] rdaddress;  
    input   [13:0] wraddress;  
    input   wren;       
    output  [15:0] q;    
`ifndef ALTERA_RESERVED_QIS
`endif
    tri1    wren;       
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule