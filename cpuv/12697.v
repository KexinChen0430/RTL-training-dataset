module rule_32_30 (
    aclr,    
    clock,   
    data,    
    rdreq,   
    wrreq,   
    q,       
    usedw    
);
input       aclr;   
input       clock;  
input [29:0] data;  
input       rdreq;  
input       wrreq;  
output [29:0] q;       
output [4:0]  usedw;   
endmodule