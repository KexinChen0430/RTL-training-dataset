
module oh_mux8  #(parameter  DW = 1)
  (input  sel7,
   input  sel6,
   input  sel5,
   input  sel4,
   input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [DW+(0-1):0] in7,
   input  [DW+(0-1):0] in6,
   input  [DW+(0-1):0] in5,
   input  [DW+(0-1):0] in4,
   input  [DW+(0-1):0] in3,
   input  [DW+(0-1):0] in2,
   input  [DW+(0-1):0] in1,
   input  [DW+(0-1):0] in0,
   output [DW+(0-1):0] out);

  assign out[DW+(0-1):0] = ((in7[DW+(0-1):0] | ((({DW{sel1}} & in1[DW+(0-1):0]) | (((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel0}}) | ((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & ({DW{sel2}} & in2[DW+(0-1):0])))) | ((({DW{sel4}} & in4[DW+(0-1):0]) | (in3[DW+(0-1):0] & {DW{sel3}})) | ({DW{sel5}} & in5[DW+(0-1):0])))) | ((((({DW{sel1}} & in1[DW+(0-1):0]) | (((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel0}}) | ((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & ({DW{sel2}} & in2[DW+(0-1):0])))) | ((((({DW{sel0}} | ({DW{sel1}} & in1[DW+(0-1):0])) & (in0[DW+(0-1):0] | ({DW{sel1}} & in1[DW+(0-1):0]))) | in3[DW+(0-1):0]) | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel3}})) | (((({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & in4[DW+(0-1):0]) | (({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & ({DW{sel5}} & in5[DW+(0-1):0]))) | {DW{sel6}})) & in6[DW+(0-1):0])) & ((((((({DW{sel1}} & in1[DW+(0-1):0]) | (((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel0}}) | ((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & ({DW{sel2}} & in2[DW+(0-1):0])))) | ((((({DW{sel0}} | ({DW{sel1}} & in1[DW+(0-1):0])) & (in0[DW+(0-1):0] | ({DW{sel1}} & in1[DW+(0-1):0]))) | in3[DW+(0-1):0]) | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel3}})) | (((({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & in4[DW+(0-1):0]) | (({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & ({DW{sel5}} & in5[DW+(0-1):0]))) | {DW{sel6}})) | {DW{sel7}}) & (((({DW{sel1}} & in1[DW+(0-1):0]) | (((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel0}}) | ((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & ({DW{sel2}} & in2[DW+(0-1):0])))) | ((((({DW{sel0}} | ({DW{sel1}} & in1[DW+(0-1):0])) & (in0[DW+(0-1):0] | ({DW{sel1}} & in1[DW+(0-1):0]))) | in3[DW+(0-1):0]) | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel3}})) | (in6[DW+(0-1):0] | ((({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & in4[DW+(0-1):0]) | (({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & ({DW{sel5}} & in5[DW+(0-1):0])))))) | (((((({DW{sel1}} & in1[DW+(0-1):0]) | (((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel0}}) | ((in0[DW+(0-1):0] | ({DW{sel2}} & in2[DW+(0-1):0])) & ({DW{sel2}} & in2[DW+(0-1):0])))) | ((((({DW{sel0}} | ({DW{sel1}} & in1[DW+(0-1):0])) & (in0[DW+(0-1):0] | ({DW{sel1}} & in1[DW+(0-1):0]))) | in3[DW+(0-1):0]) | ({DW{sel2}} & in2[DW+(0-1):0])) & {DW{sel3}})) | (((({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & in4[DW+(0-1):0]) | (({DW{sel4}} | ({DW{sel5}} & in5[DW+(0-1):0])) & ({DW{sel5}} & in5[DW+(0-1):0]))) | {DW{sel6}})) | {DW{sel7}}) & {DW{sel7}}));
endmodule

