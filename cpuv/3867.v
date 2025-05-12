module sin_altfp_sincos_cordic_atan_n6b (
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
    wire [47:0] valuenode_12_w;
    wire [47:0] valuenode_14_w;
    assign
        arctan = (({34{(~ indexbit)}} & valuenode_12_w[47:14]) | ({34{indexbit}} & valuenode_14_w[45:12])),
        valuenode_12_w = 48'b000000000000001111111111111111111111111010101011,
        valuenode_14_w = 48'b000000000000000011111111111111111111111111111011;
endmodule