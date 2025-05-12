
module recF16ToF16(input  [16:0] in,
                   output [15:0] out);

  recFNToFN #(5,11) recFNToFN(in,out);
endmodule

