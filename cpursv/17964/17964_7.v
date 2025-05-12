
module ACA_I_N32_Q8(input  [31:0] in1,
                    input  [31:0] in2,
                    output [32:0] res);

  wire [8:0] 
      temp1 ,
      temp2 ,
      temp3 ,
      temp4 ,
      temp5 ,
      temp6 ,
      temp7 ,
      temp8 ,
      temp9 ,
      temp10;
  wire [8:0] 
      temp11,
      temp12,
      temp13,
      temp14,
      temp15,
      temp16,
      temp17,
      temp18,
      temp19;
  wire [8:0] temp20,temp21,temp22,temp23,temp24,temp25;

  assign temp1[8:0] = in2[7:0]+in1[7:0];
  assign temp2[8:0] = in1[8:1]+in2[8:1];
  assign temp3[8:0] = in1[9:2]+in2[9:2];
  assign temp25[8:0] = in2[31:24]+in1[31:24];
  assign res[32:0] = {temp25[8:7],temp24[7],temp23[7],temp22[7],temp21[7],temp20[7],temp19[7],temp18[7],temp17[7],temp16[7],temp15[7],temp14[7],temp13[7],temp12[7],temp11[7],temp10[7],temp9[7],temp8[7],temp7[7],temp6[7],temp5[7],temp4[7],temp3[7],temp2[7],temp1[7:0]};
endmodule

