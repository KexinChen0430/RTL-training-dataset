
module mux4(out,in0,in1,in2,in3,sel0,sel1,sel2,sel3);

  parameter  DW = 99;
  input  [(-1)+DW:0] in0;
  input  [(-1)+DW:0] in1;
  input  [(-1)+DW:0] in2;
  input  [(-1)+DW:0] in3;
  input  sel0;
  input  sel1;
  input  sel2;
  input  sel3;
  output [(-1)+DW:0] out;

  assign out[(-1)+DW:0] = ((({DW{sel1}} & in1[(-1)+DW:0]) | ((in2[(-1)+DW:0] | {DW{sel0}}) & ((in0[(-1)+DW:0] & ((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}}))) | in2[(-1)+DW:0]))) & {DW{sel2}}) | (((in0[(-1)+DW:0] & {DW{sel0}}) | ({DW{sel3}} | ({DW{sel1}} & in1[(-1)+DW:0]))) & ((in3[(-1)+DW:0] | ((in0[(-1)+DW:0] | in1[(-1)+DW:0]) & ({DW{sel0}} | in1[(-1)+DW:0]))) & (((in0[(-1)+DW:0] | {DW{sel1}}) & (({DW{sel1}} | {DW{sel0}}) & (({DW{sel2}} | (in0[(-1)+DW:0] & {DW{sel0}})) | ((({DW{sel1}} | {DW{sel0}}) & in1[(-1)+DW:0]) & (in0[(-1)+DW:0] | {DW{sel1}}))))) | in3[(-1)+DW:0])));
endmodule

