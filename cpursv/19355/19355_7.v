
module oh_mux6  #(parameter  DW = 1)
  (input  sel5,
   input  sel4,
   input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [DW-1:0] in5,
   input  [DW-1:0] in4,
   input  [DW-1:0] in3,
   input  [DW-1:0] in2,
   input  [DW-1:0] in1,
   input  [DW-1:0] in0,
   output [DW-1:0] out);

  assign out[DW-1:0] = (((((in3[DW-1:0] & {DW{sel3}}) | in2[DW-1:0]) & {DW{sel2}}) | (((in3[DW-1:0] & {DW{sel3}}) | in2[DW-1:0]) & (in3[DW-1:0] & {DW{sel3}}))) | (({DW{sel4}} & in4[DW-1:0]) | ({DW{sel5}} & in5[DW-1:0]))) | (((((((({DW{sel1}} | in0[DW-1:0]) | {DW{sel2}}) & (({DW{sel1}} | {DW{sel0}}) | {DW{sel2}})) & ((in0[DW-1:0] | in1[DW-1:0]) & (in1[DW-1:0] | {DW{sel0}}))) | (((({DW{sel1}} | in0[DW-1:0]) | {DW{sel2}}) & (({DW{sel1}} | {DW{sel0}}) | {DW{sel2}})) & {DW{sel2}})) & in0[DW-1:0]) & {DW{sel0}}) | (((({DW{sel1}} | in0[DW-1:0]) & {DW{sel1}}) | (({DW{sel1}} | in0[DW-1:0]) & {DW{sel0}})) & in1[DW-1:0]));
endmodule

