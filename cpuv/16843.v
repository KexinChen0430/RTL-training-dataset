module dffsr(
    output reg Q,          
    input D,               
    (* clkbuf_sink *)      
    input C,               
    input R,               
    input S                
);
    parameter [0:0] INIT = 1'b0; 
    initial Q = INIT;             
    always @(posedge C or negedge S or negedge R) 
        if (!S)                   
            Q <= 1'b1;            
        else if (!R)              
            Q <= 1'b0;            
        else                      
            Q <= D;               
endmodule 