module f64ToRecF64 (input [63:0] in, output [64:0] out);
    fNToRecFN#(11, 53) fNToRecFN(in, out);
endmodule