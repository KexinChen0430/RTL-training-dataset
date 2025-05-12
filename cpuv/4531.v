module bg (
    address,
    clock,
    q
);
    input   [9:0]  address;
    input    clock;
    output   [23:0]  q;
    `ifndef ALTERA_RESERVED_QIS
    `endif
    tri1    clock;
    `ifndef ALTERA_RESERVED_QIS
    `endif
endmodule