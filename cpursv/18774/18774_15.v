
module oh_mux8  #(parameter  DW = 1)
  (input  sel7,
   input  sel6,
   input  sel5,
   input  sel4,
   input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [(-1)+DW:0] in7,
   input  [(-1)+DW:0] in6,
   input  [(-1)+DW:0] in5,
   input  [(-1)+DW:0] in4,
   input  [(-1)+DW:0] in3,
   input  [(-1)+DW:0] in2,
   input  [(-1)+DW:0] in1,
   input  [(-1)+DW:0] in0,
   output [(-1)+DW:0] out);

  assign out[(-1)+DW:0] = (((({DW{sel5}} & in5[(-1)+DW:0]) | (((in2[(-1)+DW:0] & {DW{sel2}}) | ((((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & ({DW{sel1}} & in1[(-1)+DW:0])) | (((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & (in0[(-1)+DW:0] & {DW{sel0}})))) | (({DW{sel3}} & in3[(-1)+DW:0]) | {DW{sel4}}))) | ((in6[(-1)+DW:0] & {DW{sel6}}) | ({DW{sel7}} & in7[(-1)+DW:0]))) & ((({DW{sel3}} & in3[(-1)+DW:0]) | (in4[(-1)+DW:0] | ((in2[(-1)+DW:0] & {DW{sel2}}) | ((((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & ({DW{sel1}} & in1[(-1)+DW:0])) | (((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & (in0[(-1)+DW:0] & {DW{sel0}})))))) | ({DW{sel5}} & in5[(-1)+DW:0]))) | (((({DW{sel5}} & in5[(-1)+DW:0]) | (((in2[(-1)+DW:0] & {DW{sel2}}) | ((((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & ({DW{sel1}} & in1[(-1)+DW:0])) | (((((in0[(-1)+DW:0] | {DW{sel1}}) & ({DW{sel1}} | {DW{sel0}})) | in2[(-1)+DW:0]) & (((({DW{sel0}} | in1[(-1)+DW:0]) & in0[(-1)+DW:0]) | (({DW{sel0}} | in1[(-1)+DW:0]) & in1[(-1)+DW:0])) | in2[(-1)+DW:0])) & (in0[(-1)+DW:0] & {DW{sel0}})))) | (({DW{sel3}} & in3[(-1)+DW:0]) | {DW{sel4}}))) | ((in6[(-1)+DW:0] & {DW{sel6}}) | ({DW{sel7}} & in7[(-1)+DW:0]))) & ((in6[(-1)+DW:0] & {DW{sel6}}) | ({DW{sel7}} & in7[(-1)+DW:0])));
endmodule

