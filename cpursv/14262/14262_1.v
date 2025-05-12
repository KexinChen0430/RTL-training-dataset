
module recF32ToF32(input  [32:0] in,
                   output [31:0] out);

  recFNToFN #(8,24) recFNToFN(in,out);
endmodule

