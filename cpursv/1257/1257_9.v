
module mux4(out,in0,in1,in2,in3,sel0,sel1,sel2,sel3);

  parameter  DW = 99;
  input  [DW+(0-1):0] in0;
  input  [DW+(0-1):0] in1;
  input  [DW+(0-1):0] in2;
  input  [DW+(0-1):0] in3;
  input  sel0;
  input  sel1;
  input  sel2;
  input  sel3;
  output [DW+(0-1):0] out;

  assign out[DW+(0-1):0] = (((((in1[DW+(0-1):0] | {DW{sel0}}) & (in1[DW+(0-1):0] | in0[DW+(0-1):0])) & {DW{sel1}}) | ({DW{sel2}} | (in3[DW+(0-1):0] & {DW{sel3}}))) | ({DW{sel0}} & (in0[DW+(0-1):0] & (({DW{sel0}} | {DW{sel1}}) & ({DW{sel1}} | in0[DW+(0-1):0]))))) & ((({DW{sel1}} & (in1[DW+(0-1):0] & (({DW{sel1}} | in0[DW+(0-1):0]) & (in1[DW+(0-1):0] | in0[DW+(0-1):0])))) | ((in3[DW+(0-1):0] & {DW{sel3}}) | in2[DW+(0-1):0])) | (in0[DW+(0-1):0] & ((in1[DW+(0-1):0] | {DW{sel0}}) & ({DW{sel0}} | {DW{sel1}}))));
endmodule

