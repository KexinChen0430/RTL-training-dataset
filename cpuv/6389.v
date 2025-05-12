module R_SEQ (
    address,  
    clock,    
    q);       
    input   [7:0]  address;
    input   clock;
    output  [127:0]  q;
endmodule