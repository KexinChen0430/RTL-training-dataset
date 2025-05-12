
module recF64ToF64(input  [64:0] in,
                   output [63:0] out);

  recFNToFN #(11,53) recFNToFN(in,out);
endmodule

