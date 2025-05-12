module mux(
    input select, 
    input x,      
    input y,      
    output z      
);
    assign z = (x & ~select) | (y & select);
endmodule 