
module oh_mux12  #(parameter  DW = 1)
  (input  sel11,
   input  sel10,
   input  sel9,
   input  sel8,
   input  sel7,
   input  sel6,
   input  sel5,
   input  sel4,
   input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [(0-1)+DW:0] in11,
   input  [(0-1)+DW:0] in10,
   input  [(0-1)+DW:0] in9,
   input  [(0-1)+DW:0] in8,
   input  [(0-1)+DW:0] in7,
   input  [(0-1)+DW:0] in6,
   input  [(0-1)+DW:0] in5,
   input  [(0-1)+DW:0] in4,
   input  [(0-1)+DW:0] in3,
   input  [(0-1)+DW:0] in2,
   input  [(0-1)+DW:0] in1,
   input  [(0-1)+DW:0] in0,
   output [(0-1)+DW:0] out);

  assign out[(0-1)+DW:0] = ((({DW{sel11}} & in11[(0-1)+DW:0]) | (((({DW{sel4}} & in4[(0-1)+DW:0]) | ((((((in0[(0-1)+DW:0] & {DW{sel0}}) | ({DW{sel1}} & in1[(0-1)+DW:0])) | (in2[(0-1)+DW:0] & {DW{sel2}})) | ({DW{sel5}} & in5[(0-1)+DW:0])) | (in3[(0-1)+DW:0] & (({DW{sel1}} & in1[(0-1)+DW:0]) | ({DW{sel3}} | ((in0[(0-1)+DW:0] & {DW{sel0}}) | (in2[(0-1)+DW:0] & {DW{sel2}})))))) | {DW{sel6}})) | ((({DW{sel8}} & in8[(0-1)+DW:0]) | {DW{sel7}}) & (({DW{sel8}} & in8[(0-1)+DW:0]) | in7[(0-1)+DW:0]))) & ((((({DW{sel4}} & in4[(0-1)+DW:0]) | ({DW{sel5}} & in5[(0-1)+DW:0])) | in6[(0-1)+DW:0]) | (((in3[(0-1)+DW:0] | ((in2[(0-1)+DW:0] & {DW{sel2}}) | ({DW{sel1}} & in1[(0-1)+DW:0]))) | (in0[(0-1)+DW:0] & {DW{sel0}})) & (({DW{sel1}} & in1[(0-1)+DW:0]) | ({DW{sel3}} | ((in0[(0-1)+DW:0] & {DW{sel0}}) | (in2[(0-1)+DW:0] & {DW{sel2}})))))) | ((({DW{sel8}} & in8[(0-1)+DW:0]) | {DW{sel7}}) & (({DW{sel8}} & in8[(0-1)+DW:0]) | in7[(0-1)+DW:0]))))) | ({DW{sel9}} & in9[(0-1)+DW:0])) | ({DW{sel10}} & in10[(0-1)+DW:0]);
endmodule

