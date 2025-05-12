
module e16_mux7(out,in0,in1,in2,in3,in4,in5,in6,sel0,sel1,sel2,sel3,sel4,
                sel5,sel6);

  parameter  DW = 99;
  input  [DW+(0-1):0] in0;
  input  [DW+(0-1):0] in1;
  input  [DW+(0-1):0] in2;
  input  [DW+(0-1):0] in3;
  input  [DW+(0-1):0] in4;
  input  [DW+(0-1):0] in5;
  input  [DW+(0-1):0] in6;
  input  sel0;
  input  sel1;
  input  sel2;
  input  sel3;
  input  sel4;
  input  sel5;
  input  sel6;
  output [DW+(0-1):0] out;

  assign out[DW+(0-1):0] = (({DW{sel5}} & in5[DW+(0-1):0]) | ({DW{sel6}} & in6[DW+(0-1):0])) | ((in4[DW+(0-1):0] & {DW{sel4}}) | (((in3[DW+(0-1):0] | (((in0[DW+(0-1):0] | (in1[DW+(0-1):0] & {DW{sel1}})) | {DW{sel2}}) & (((in1[DW+(0-1):0] & {DW{sel1}}) | {DW{sel0}}) | {DW{sel2}}))) & (((in2[DW+(0-1):0] | (in0[DW+(0-1):0] | (in1[DW+(0-1):0] & {DW{sel1}}))) & (in2[DW+(0-1):0] | ((in1[DW+(0-1):0] & {DW{sel1}}) | {DW{sel0}}))) | in3[DW+(0-1):0])) & ((((in2[DW+(0-1):0] | (in0[DW+(0-1):0] | (in1[DW+(0-1):0] & {DW{sel1}}))) & (in2[DW+(0-1):0] | ((in1[DW+(0-1):0] & {DW{sel1}}) | {DW{sel0}}))) & (((in0[DW+(0-1):0] | (in1[DW+(0-1):0] & {DW{sel1}})) | {DW{sel2}}) & (((in1[DW+(0-1):0] & {DW{sel1}}) | {DW{sel0}}) | {DW{sel2}}))) | ({DW{sel3}} | (in4[DW+(0-1):0] & {DW{sel4}})))));
  
  always @* 
      if (($time & (((((sel5+sel1)+sel6)+sel4)+((sel2+sel3)+sel0)) > 1)) > 0) 
        $display("ERROR>>Arbitration failure in cell %m");
        
endmodule

