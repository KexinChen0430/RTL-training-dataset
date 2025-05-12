module dffns( 
    output reg Q, 
    input D, 
    (* clkbuf_sink *) 
    input C, 
    input S 
);
    parameter [0:0] INIT = 1'b0; 
    initial Q = INIT; 
    always @(negedge C or negedge S) 
        if (!S) 
            Q <= 1'b1; 
        else 
            Q <= D; 
endmodule 