module capture_fifo (
    aclr,      
    data,      
    rdclk,     
    rdreq,     
    wrclk,     
    wrreq,     
    q,         
    rdempty,   
    rdfull,    
    rdusedw,   
    wrempty,   
    wrfull);   
input       aclr;
input  [63:0] data;
input       rdclk;
input       rdreq;
input       wrclk;
input       wrreq;
output [31:0] q;
output       rdempty;
output       rdfull;
output  [4:0] rdusedw;
output       wrempty;
output       wrfull;
`ifndef ALTERA_RESERVED_QIS
`endif
    tri0       aclr; 
`ifndef ALTERA_RESERVED_QIS
`endif
endmodule