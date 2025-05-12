
module e16_mux7(out,in0,in1,in2,in3,in4,in5,in6,sel0,sel1,sel2,sel3,sel4,
                sel5,sel6);

  parameter  DW = 99;
  input  [(-1)+DW:0] in0;
  input  [(-1)+DW:0] in1;
  input  [(-1)+DW:0] in2;
  input  [(-1)+DW:0] in3;
  input  [(-1)+DW:0] in4;
  input  [(-1)+DW:0] in5;
  input  [(-1)+DW:0] in6;
  input  sel0;
  input  sel1;
  input  sel2;
  input  sel3;
  input  sel4;
  input  sel5;
  input  sel6;
  output [(-1)+DW:0] out;

  assign out[(-1)+DW:0] = (((in5[(-1)+DW:0] | ({DW{sel4}} & in4[(-1)+DW:0])) & (({DW{sel6}} & in6[(-1)+DW:0]) | (({DW{sel5}} | (((((((in1[(-1)+DW:0] | {DW{sel0}}) & (in0[(-1)+DW:0] | in1[(-1)+DW:0])) & {DW{sel0}}) & in0[(-1)+DW:0]) | (in3[(-1)+DW:0] & {DW{sel3}})) | (in1[(-1)+DW:0] & {DW{sel1}})) | (in2[(-1)+DW:0] & {DW{sel2}}))) | ({DW{sel4}} & in4[(-1)+DW:0])))) | ((((((((in1[(-1)+DW:0] | {DW{sel0}}) & (in0[(-1)+DW:0] | in1[(-1)+DW:0])) & {DW{sel0}}) & in0[(-1)+DW:0]) | (in3[(-1)+DW:0] & {DW{sel3}})) | (in1[(-1)+DW:0] & {DW{sel1}})) | (in2[(-1)+DW:0] & {DW{sel2}})) & (({DW{sel6}} & in6[(-1)+DW:0]) | (({DW{sel5}} | (((((((in1[(-1)+DW:0] | {DW{sel0}}) & (in0[(-1)+DW:0] | in1[(-1)+DW:0])) & {DW{sel0}}) & in0[(-1)+DW:0]) | (in3[(-1)+DW:0] & {DW{sel3}})) | (in1[(-1)+DW:0] & {DW{sel1}})) | (in2[(-1)+DW:0] & {DW{sel2}}))) | ({DW{sel4}} & in4[(-1)+DW:0]))))) | ({DW{sel6}} & in6[(-1)+DW:0]);
  
  always @* 
      if (($time & ((((sel6+sel2)+sel0)+(((sel5+sel4)+sel1)+sel3)) > 1)) > 0) 
        $display("ERROR>>Arbitration failure in cell %m");
        
endmodule

