module comparator (
    input  wire [`WIDTH-1:0] A,
    input  wire [`WIDTH-1:0] B,
    output wire CO,
);
    assign CO = (A <= B) ? 1'b1 : 1'b0;
endmodule