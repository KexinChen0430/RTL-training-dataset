module \$_DFF_NP0_ (D, C, R, Q);
    input D; 
    input C; 
    input R; 
    output reg Q; 
    always @(negedge C or posedge R) begin
        if (R == 1) 
            Q <= 0; 
        else
            Q <= D; 
    end
endmodule