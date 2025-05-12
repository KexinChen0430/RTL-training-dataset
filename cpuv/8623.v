module coincidence_counter (
    aclr,    
    clock,   
    cnt_en,  
    q);      
    input   aclr;
    input   clock;
    input   cnt_en;
    output  [21:0]  q;
endmodule