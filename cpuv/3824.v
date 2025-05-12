module sin_altfp_sincos_cordic_atan_95b
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
    wire [47:0] valuenode_5_w;
    wire [47:0] valuenode_7_w;
    assign
        arctan = (({34{(~ indexbit)}} & valuenode_5_w[47:14]) | ({34{indexbit}} & valuenode_7_w[45:12])),
        valuenode_5_w = 48'b000000011111111111010101010110111011101010010111,
        valuenode_7_w = 48'b000000000111111111111111010101010101011011101111;
endmodule