module \$_SDFFE_NN0N_ (D, C, R, E, Q);
    input D; 
    input C; 
    input R; 
    input E; 
    output reg Q; 
    always @(negedge C) begin
        if (R == 0) 
            Q <= 0; 
        else if (E == 0) 
            Q <= D; 
    end
endmodule