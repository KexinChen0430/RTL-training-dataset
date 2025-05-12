module sin_altfp_sincos_cordic_atan_45b
    (
    arctan,
    indexbit) ;
    output   [33:0]  arctan; 
    input   indexbit; 
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri0   indexbit; 
    `ifndef ALTERA_RESERVED_QIS
    `endif
    wire  [47:0]  valuenode_0_w;
    wire  [47:0]  valuenode_2_w;
    assign
        arctan = (({34{(~ indexbit)}} & valuenode_0_w[47:14]) | ({34{indexbit}} & valuenode_2_w[45:12])),
        valuenode_0_w = 48'b001100100100001111110110101010001000100001011010,
        valuenode_2_w = 48'b000011111010110110111010111111001001011001000000;
endmodule