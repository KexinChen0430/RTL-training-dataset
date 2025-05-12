module buffer (
    aclr,       
    data,       
    rdclk,      
    rdreq,      
    wrclk,      
    wrreq,      
    q,          
    rdempty,    
    wrfull      
);
input       aclr;       
input [7:0] data;       
input       rdclk;      
input       rdreq;      
input       wrclk;      
input       wrreq;      
output [7:0] q;         
output      rdempty;    
output      wrfull;     
`ifndef ALTERA_RESERVED_QIS
`endif
tri0        aclr;
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule