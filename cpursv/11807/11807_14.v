
module SFPU_MUL(SRC1,SRC2,MRESULT,NZEXP,OUT);

  input  [31:0] SRC1,SRC2;
  input  [47:0] MRESULT;
  input  [2:1] NZEXP;
  output [36:0] OUT;
  wire [9:0] exponent,expoh,expol;
  wire [1:0] restlow,resthigh;
  wire zero,sign,orlow;

  assign zero = ~NZEXP[1] | ~NZEXP[2];
  assign sign = (((SRC1[31] | (~SRC1[31] & ~zero)) & (~SRC1[31] & ~zero)) | ((SRC1[31] | (~SRC1[31] & ~zero)) & (~zero & ~SRC2[31]))) & ((~SRC1[31] & SRC2[31]) | (~zero & SRC1[31]));
  assign orlow = MRESULT[21:0] != 22'b0;
  assign restlow = {MRESULT[22],orlow};
  assign resthigh = {MRESULT[23],MRESULT[22] | orlow};
  assign exponent = {2'b00,SRC2[30:23]}+{2'b00,SRC1[30:23]};
  assign expoh = (-10'h07E)+exponent;
  assign expol = (-10'h07F)+exponent;
  assign OUT = MRESULT[47] ? {zero,sign,expoh,MRESULT[46:24],resthigh} : {zero,sign,expol,MRESULT[45:23],restlow};
endmodule

