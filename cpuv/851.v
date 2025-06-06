module float_add_sub_altpriority_encoder_nh8 (
    data,   
    q,      
    zero    
);
    input   [1:0]  data; 
    output  [0:0]  q;    
    output  zero;        
    assign q = {(~ data[0])};
    assign zero = (~ (data[0] | data[1]));
endmodule 