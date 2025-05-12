
module ACA_I_N16_Q4(input  [15:0] in1,
                    input  [15:0] in2,
                    output [16:0] res);

  wire [4:0] 
      temp1 ,
      temp2 ,
      temp3 ,
      temp4 ,
      temp5 ,
      temp6 ,
      temp7 ,
      temp8 ,
      temp9 ,
      temp10,
      temp11,
      temp12,
      temp13;

  assign temp1[4:0] = in2[3:0]+in1[3:0];
  assign temp2[4:0] = in1[4:1]+in2[4:1];
  assign temp3[4:0] = in2[5:2]+in1[5:2];
  assign res[16:0] = {temp13[4:3],temp12[3],temp11[3],temp10[3],temp9[3],temp8[3],temp7[3],temp6[3],temp5[3],temp4[3],temp3[3],temp2[3],temp1[3:0]};
endmodule

