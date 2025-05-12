module fifo_4kx16_dc (
    aclr,       
    data,       
    rdclk,      
    rdreq,      
    wrclk,      
    wrreq,      
    q,          
    rdempty,    
    rdusedw,    
    wrfull,     
    wrusedw     
);
input       aclr;           
input [15:0] data;          
input       rdclk;          
input       rdreq;          
input       wrclk;          
input       wrreq;          
output [15:0] q;            
output      rdempty;        
output [11:0] rdusedw;      
output      wrfull;         
output [11:0] wrusedw;      
endmodule 