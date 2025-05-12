
module oh_mux5  #(parameter  DW = 1)
  (input  sel4,
   input  sel3,
   input  sel2,
   input  sel1,
   input  sel0,
   input  [(0-1)+DW:0] in4,
   input  [(0-1)+DW:0] in3,
   input  [(0-1)+DW:0] in2,
   input  [(0-1)+DW:0] in1,
   input  [(0-1)+DW:0] in0,
   output [(0-1)+DW:0] out);

  assign out[(0-1)+DW:0] = ((((in2[(0-1)+DW:0] & {DW{sel2}}) | in0[(0-1)+DW:0]) | (({DW{sel3}} | (in4[(0-1)+DW:0] & {DW{sel4}})) & (in3[(0-1)+DW:0] | (in4[(0-1)+DW:0] & {DW{sel4}})))) & ((({DW{sel3}} | (in4[(0-1)+DW:0] & {DW{sel4}})) & (in3[(0-1)+DW:0] | (in4[(0-1)+DW:0] & {DW{sel4}}))) | ((in2[(0-1)+DW:0] & {DW{sel2}}) | {DW{sel0}}))) | ({DW{sel1}} & (({DW{sel0}} & in0[(0-1)+DW:0]) | in1[(0-1)+DW:0]));
endmodule

