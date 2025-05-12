module rom (
    address,  
    clock,    
    rden,     
    q);       
    input   [7:0]  address; 
    input     clock;        
    input     rden;         
    output  [31:0]  q;      
`ifndef ALTERA_RESERVED_QIS
`endif
    tri1     clock;         
    tri1     rden;          
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule