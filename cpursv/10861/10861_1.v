
module oh_add  #(parameter  DW = 1)
  (input  [DW+(0-1):0] a,
   input  [DW+(0-1):0] b,
   input  opt_sub,
   input  cin,
   output [DW+(0-1):0] sum,
   output cout,
   output zero,
   output neg,
   output overflow);

  wire [DW+(0-1):0] b_sub;

  assign b_sub[DW+(0-1):0] = (b[DW+(0-1):0] & (~{DW{opt_sub}} | {DW{opt_sub}})) ^ ((((~b[DW+(0-1):0] | b[DW+(0-1):0]) & {DW{opt_sub}}) & (~{DW{opt_sub}} | {DW{opt_sub}})) & ((b[DW+(0-1):0] & (~{DW{opt_sub}} | {DW{opt_sub}})) | {DW{opt_sub}}));
  assign {cout,sum[DW+(0-1):0]} = (cin+opt_sub)+(b_sub[DW+(0-1):0]+a[DW+(0-1):0]);
endmodule

