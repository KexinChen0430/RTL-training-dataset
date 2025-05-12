module SB_DFFNSR (output reg Q, input C, R, D); 
    `SB_DFF_REG
    always @(negedge C)
        if (R)
            Q <= 0;
        else
            Q <= D;
endmodule