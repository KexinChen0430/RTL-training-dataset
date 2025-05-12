module ADD(
    input a,  
    input b,  
    input c,  
    output g, 
    output p, 
    output s  
);
assign s = a ^ b ^ c;
assign g = a & b;
assign p = a | b;
endmodule 