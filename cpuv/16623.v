module ODDR(D0, D1, TX, CLK, Q0, Q1);
    input D0;       
    input D1;       
    input TX;       
    input CLK;      
    output Q0;      
    output Q1;      
    parameter TXCLK_POL = 0;
    parameter INIT = 0;
endmodule