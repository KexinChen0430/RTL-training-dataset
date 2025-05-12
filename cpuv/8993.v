module COUNTER (
    aclr,    
    clock,   
    cnt_en,  
    q);      
    input       aclr;
    input       clock;
    input       cnt_en;
    output  [13:0]  q;
endmodule