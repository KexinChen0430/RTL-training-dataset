module dffn(
    output reg Q,       
    input D,            
    (* clkbuf_sink *)   
    input C             
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(negedge C)
            Q <= D; 
endmodule 