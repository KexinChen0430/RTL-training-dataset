module sin_altfp_sincos_cordic_atan_a5b
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
    wire [47:0] valuenode_6_w;
    wire [47:0] valuenode_8_w;
    assign
        arctan = (({34{(~ indexbit)}} & valuenode_6_w[47:14]) | 
                  ({34{indexbit}} & valuenode_8_w[45:12])),      
        valuenode_6_w = 48'b000000001111111111111010101010101101110111011100, 
        valuenode_8_w = 48'b000000000011111111111111111010101010101010110111; 
endmodule