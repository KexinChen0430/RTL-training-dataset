module gold( 
    off, fib0, fib1, fib2, fib3, fib4, fib5, fib6, fib7, fib8, fib9 
);
    input wire signed [31:0] off; 
    output integer fib0 = off + 0; 
    output integer fib1 = off + 1; 
    output integer fib2 = off + 1; 
    output integer fib3 = off + 2; 
    output integer fib4 = off + 3; 
    output integer fib5 = off + 5; 
    output integer fib6 = off + 8; 
    output integer fib7 = off + 13; 
    output integer fib8 = off + 21; 
    output integer fib9 = off + 34; 
endmodule 