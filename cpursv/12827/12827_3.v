
module oh_mux4  #(parameter  DW = 1)
  (input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [DW+(-1):0] in3,
   input  [DW+(-1):0] in2,
   input  [DW+(-1):0] in1,
   input  [DW+(-1):0] in0,
   output [DW+(-1):0] out);

  assign out[DW+(-1):0] = ((in1[DW+(-1):0] | in0[DW+(-1):0]) & ((in1[DW+(-1):0] | {DW{sel0}}) & ((in2[DW+(-1):0] & {DW{sel2}}) | ({DW{sel1}} | (({DW{sel1}} | {DW{sel0}}) & in0[DW+(-1):0]))))) | (({DW{sel3}} | (in2[DW+(-1):0] & {DW{sel2}})) & (in3[DW+(-1):0] | (in2[DW+(-1):0] & {DW{sel2}})));
endmodule

