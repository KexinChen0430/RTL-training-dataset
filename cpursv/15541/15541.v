
module f16ToRecF16(input  [15:0] in,
                   output [16:0] out);

  fNToRecFN #(5,11) fNToRecFN(in,out);
endmodule

