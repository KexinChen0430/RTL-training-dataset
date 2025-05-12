module LDCP_N (G, PRE, CLR, D, Q);
    parameter INIT = 0;
    input G, PRE, CLR, D;
    output reg Q;
    initial begin
        Q <= INIT; 
    end
    always @* begin
        if (CLR == 1) 
            Q <= 0; 
        else if (G == 0) 
            Q <= D; 
        else if (PRE == 1) 
            Q <= 1; 
    end
endmodule