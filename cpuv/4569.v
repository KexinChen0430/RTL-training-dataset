module asl(value1, value2, shift_hex, value_out, EN);
    input [31:0] value1, value2;
    input [3:0] shift_hex;
    output [31:0] value_out;
    input EN;
    wire or_unary = |value2[31:5];
    wire value2_shrink = value2[4:0];
    wire [4:0] shift_amt = (value2_shrink == 32'b0) ?
        ( {1'b0, shift_hex} + 5'b1) : (value2_shrink + {1'b0, shift_hex});
    assign value_out = (or_unary == 1'b1) ? 32'b0 : (
        (shift_amt == 5'b00000) ? value1[31:0] :
        (shift_amt == 5'b00001) ? {value1[30:0], 1'b0 } :
        (shift_amt == 5'b00010) ? {value1[29:0], 2'b0 } :
        (shift_amt == 5'b11110) ? {value1[1:0], 30'b0 } :
        (shift_amt == 5'b11111) ? {value1[0:0], 31'b0 } : 32'b0);
endmodule