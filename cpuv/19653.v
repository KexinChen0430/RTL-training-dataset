module ms_add (
    input byte signed a, 
    input byte signed b, 
    output byte signed sc, 
    output reg byte signed ss 
);
assign sc = a + b;
always @(a, b) ss = a + b;
endmodule 