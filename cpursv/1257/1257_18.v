
module mux4(out,in0,in1,in2,in3,sel0,sel1,sel2,sel3);

  parameter  DW = 99;
  input  [(0-1)+DW:0] in0;
  input  [(0-1)+DW:0] in1;
  input  [(0-1)+DW:0] in2;
  input  [(0-1)+DW:0] in3;
  input  sel0;
  input  sel1;
  input  sel2;
  input  sel3;
  output [(0-1)+DW:0] out;

  assign out[(0-1)+DW:0] = (((in1[(0-1)+DW:0] & (in0[(0-1)+DW:0] & ((({DW{sel0}} | in1[(0-1)+DW:0]) & (in0[(0-1)+DW:0] | in1[(0-1)+DW:0])) & {DW{sel0}}))) | (in1[(0-1)+DW:0] & {DW{sel1}})) | (({DW{sel2}} | (in0[(0-1)+DW:0] & ((({DW{sel0}} | in1[(0-1)+DW:0]) & (in0[(0-1)+DW:0] | in1[(0-1)+DW:0])) & {DW{sel0}}))) & ((in2[(0-1)+DW:0] | {DW{sel0}}) & (in2[(0-1)+DW:0] | in0[(0-1)+DW:0])))) | (in3[(0-1)+DW:0] & {DW{sel3}});
endmodule

