
module oh_add  #(parameter  DW = 1)
  (input  [(-1)+DW:0] a,
   input  [(-1)+DW:0] b,
   input  opt_sub,
   input  cin,
   output [(-1)+DW:0] sum,
   output cout,
   output zero,
   output neg,
   output overflow);

  wire [(-1)+DW:0] b_sub;

  assign b_sub[(-1)+DW:0] = (((~{DW{opt_sub}} & ({DW{opt_sub}} | b[(-1)+DW:0])) | (~{DW{opt_sub}} | {DW{opt_sub}})) & {DW{opt_sub}}) ^ ((b[(-1)+DW:0] & (~{DW{opt_sub}} | {DW{opt_sub}})) & ((~{DW{opt_sub}} & ({DW{opt_sub}} | b[(-1)+DW:0])) | (~{DW{opt_sub}} | {DW{opt_sub}})));
  assign {cout,sum[(-1)+DW:0]} = (b_sub[(-1)+DW:0]+(cin+opt_sub))+a[(-1)+DW:0];
endmodule

