module sin_altfp_sincos_cordic_atan_75b
    (
    arctan,
    indexbit
    );
    output [33:0] arctan;
    input indexbit;
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri0 indexbit;
    `ifndef ALTERA_RESERVED_QIS
    `endif
    wire [47:0] valuenode_3_w;
    wire [47:0] valuenode_5_w;
    assign
        arctan = (({34{(~ indexbit)}} & valuenode_3_w[47:14]) | ({34{indexbit}} & valuenode_5_w[45:12])),
        valuenode_3_w = 48'b000001111111010101101110101001101010101100001100,
        valuenode_5_w = 48'b000000011111111111010101010110111011101010010111;
endmodule