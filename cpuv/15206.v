module sub (
    input [7:0] allbits, 
    input [1:0] onebit,  
    output bitout        
);
`INLINE_MODULE
assign bitout = (^ onebit) ^ (^ allbits);
endmodule 