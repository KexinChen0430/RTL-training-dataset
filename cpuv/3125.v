module asyn_64_1 (
    aclr,      
    data,      
    rdclk,     
    rdreq,     
    wrclk,     
    wrreq,     
    q,         
    rdempty);  
input   aclr;      
input   [0:0] data; 
input   rdclk;      
input   rdreq;      
input   wrclk;      
input   wrreq;      
output  [0:0] q;    
output  rdempty;    
`ifndef ALTERA_RESERVED_QIS
`endif
    tri0    aclr; 
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule