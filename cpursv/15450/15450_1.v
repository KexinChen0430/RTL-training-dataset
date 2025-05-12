
module f128ToRecF128(input  [127:0] in,
                     output [128:0] out);

  fNToRecFN #(15,113) fNToRecFN(in,out);
endmodule

