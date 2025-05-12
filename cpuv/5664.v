module SB_DFFES (output reg Q, input C, E, S, D); 
    `SB_DFF_REG
    always @(posedge C, posedge S)
        if (S) 
            Q <= 1; 
        else if (E) 
            Q <= D; 
endmodule