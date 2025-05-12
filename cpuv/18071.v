module PULLUHD (Z, E);
    output Z;
    input  E;
    bufif1 _i0 (Z, 1'b1, E);
    specify
        (E => Z) = (0,0,0,0,0,0);
    endspecify
endmodule