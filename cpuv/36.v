module maj (
    input [31:0] x, 
    input [31:0] y, 
    input [31:0] z, 
    output [31:0] o 
);
    assign o = (x & y) | (z & (x | y));
endmodule 