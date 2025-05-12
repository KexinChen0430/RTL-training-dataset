module SB_DFFNR (output reg Q, input C, R, D); 
    `SB_DFF_REG
    always @(negedge C, posedge R)
        if (R)
            Q <= 0;
        else
            Q <= D;
endmodule