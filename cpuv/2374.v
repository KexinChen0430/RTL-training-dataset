module fifo_57x64 (
    aclr,       
    data,       
    rdclk,      
    rdreq,      
    wrclk,      
    wrreq,      
    q,          
    rdempty,    
    wrempty,    
    wrfull,     
    wrusedw     
);
    input       aclr;       
    input [56:0] data;      
    input       rdclk;      
    input       rdreq;      
    input       wrclk;      
    input       wrreq;      
    output [56:0] q;        
    output      rdempty;    
    output      wrempty;    
    output      wrfull;     
    output [5:0] wrusedw;   
    `ifndef ALTERA_RESERVED_QIS
    `endif
        tri0 aclr;
    `ifndef ALTERA_RESERVED_QIS
    `endif
endmodule