module SB_DFFNESS (output Q, input C, E, S, D); 
`SB_DFF_REG 
always @(negedge C) 
    if (E) begin 
        if (S) 
            Q <= 1; 
        else 
            Q <= D; 
    end
endmodule 