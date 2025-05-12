module dffsre(
    output reg Q,    
    input D,         
    (* clkbuf_sink *) 
    input C,         
    input E,         
    input R,         
    input S          
);
    parameter [0:0] INIT = 1'b0; 
    initial Q = INIT;
    always @(posedge C or negedge S or negedge R)
        if (!R)               
            Q <= 1'b0;        
        else if (!S)          
            Q <= 1'b1;        
        else if (E)           
            Q <= D;           
endmodule