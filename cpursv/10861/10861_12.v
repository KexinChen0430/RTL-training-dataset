
module oh_add  #(parameter  DW = 1)
  (input  [(0-1)+DW:0] a,
   input  [(0-1)+DW:0] b,
   input  opt_sub,
   input  cin,
   output [(0-1)+DW:0] sum,
   output cout,
   output zero,
   output neg,
   output overflow);

  wire [(0-1)+DW:0] b_sub;

  assign b_sub[(0-1)+DW:0] = ((((~{DW{opt_sub}} | ~b[(0-1)+DW:0]) & {DW{opt_sub}}) & (({DW{opt_sub}} | ~{DW{opt_sub}}) | ((({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])) & ~{DW{opt_sub}}) | ((~{DW{opt_sub}} & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) ^ (((({DW{opt_sub}} & b[(0-1)+DW:0]) & ~((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}})) | (~({DW{opt_sub}} & b[(0-1)+DW:0]) & ((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}}))) & ~{DW{opt_sub}}))))) & (~{DW{opt_sub}} | ~b[(0-1)+DW:0])) ^ (((~((({DW{opt_sub}} | ~{DW{opt_sub}}) | ((({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])) & ~{DW{opt_sub}}) | ((~{DW{opt_sub}} & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) ^ (((({DW{opt_sub}} & b[(0-1)+DW:0]) & ~((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}})) | (~({DW{opt_sub}} & b[(0-1)+DW:0]) & ((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}}))) & ~{DW{opt_sub}})))) & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) & ((({DW{opt_sub}} | ~{DW{opt_sub}}) | ((({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])) & ~{DW{opt_sub}}) | ((~{DW{opt_sub}} & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) ^ (((({DW{opt_sub}} & b[(0-1)+DW:0]) & ~((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}})) | (~({DW{opt_sub}} & b[(0-1)+DW:0]) & ((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}}))) & ~{DW{opt_sub}})))) & (((~{DW{opt_sub}} | ~b[(0-1)+DW:0]) & {DW{opt_sub}}) & b[(0-1)+DW:0]))) | (((({DW{opt_sub}} | ~{DW{opt_sub}}) | ((({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])) & ~{DW{opt_sub}}) | ((~{DW{opt_sub}} & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) ^ (((({DW{opt_sub}} & b[(0-1)+DW:0]) & ~((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}})) | (~({DW{opt_sub}} & b[(0-1)+DW:0]) & ((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}}))) & ~{DW{opt_sub}})))) & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) & ~((({DW{opt_sub}} | ~{DW{opt_sub}}) | ((({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])) & ~{DW{opt_sub}}) | ((~{DW{opt_sub}} & (b[(0-1)+DW:0] & (b[(0-1)+DW:0] ^ (b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0])))))) ^ (((({DW{opt_sub}} & b[(0-1)+DW:0]) & ~((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}})) | (~({DW{opt_sub}} & b[(0-1)+DW:0]) & ((b[(0-1)+DW:0] & ({DW{opt_sub}} & (~b[(0-1)+DW:0] | b[(0-1)+DW:0]))) & {DW{opt_sub}}))) & ~{DW{opt_sub}})))) & (((~{DW{opt_sub}} | ~b[(0-1)+DW:0]) & {DW{opt_sub}}) & b[(0-1)+DW:0])))) & (~{DW{opt_sub}} | ~b[(0-1)+DW:0]));
  assign {cout,sum[(0-1)+DW:0]} = (cin+a[(0-1)+DW:0])+(opt_sub+b_sub[(0-1)+DW:0]);
endmodule

