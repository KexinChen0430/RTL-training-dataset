
module recF128ToF128(input  [128:0] in,
                     output [127:0] out);

  recFNToFN #(15,113) recFNToFN(in,out);
endmodule

