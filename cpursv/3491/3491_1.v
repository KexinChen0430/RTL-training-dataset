
module shift_left_32(input  [31:0] a,
                     output [31:0] out);

  assign out[0] = a[31];
  assign out[1] = a[0];
  assign out[2] = a[1];
  assign out[30] = a[29];
  assign out[31] = a[30];
endmodule

