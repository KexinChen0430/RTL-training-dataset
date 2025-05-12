module cnt_64bit (
    aclr,    
    clock,   
    cnt_en,  
    data,    
    sload,   
    q);      
    input	  aclr;
    input	  clock;
    input	  cnt_en;
    input	[63:0]  data;
    input	  sload;
    output	[63:0]  q;
endmodule