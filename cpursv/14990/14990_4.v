
module jbi_adder_4b(sum,cout,oper1,oper2,cin);

  input  [3:0] oper1;
  input  [3:0] oper2;
  input  cin;
  output [3:0] sum;
  output cout;
  wire [3:0] gen,prop;
  wire [4:0] carry;

  assign carry[0] = cin;
  assign gen[0] = oper2[0] & oper1[0];
  assign prop[0] = oper2[0] | oper1[0];
  assign sum[0] = (oper2[0] ^ oper1[0]) ^ carry[0];
  assign carry[1] = gen[0] | ((prop[0] | gen[0]) & carry[0]);
  assign gen[1] = oper1[1] & oper2[1];
  assign prop[1] = oper1[1] | oper2[1];
  assign sum[1] = ((carry[1] & ~(oper2[1] ^ oper1[1])) | (oper2[1] ^ oper1[1])) & (~(oper2[1] ^ oper1[1]) | ~carry[1]);
  assign carry[2] = (gen[1] | ((gen[1] | (prop[0] & carry[0])) & prop[1])) | ((prop[1] & gen[0]) | (carry[0] & (prop[0] & prop[1])));
  assign gen[2] = oper1[2] & oper2[2];
  assign prop[2] = oper2[2] | oper1[2];
  assign sum[2] = (carry[2] & (~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2])) | ((((carry[2] | (~(oper2[2] & ~carry[2]) & (oper1[2] & ~carry[2]))) | ((oper2[2] & ~carry[2]) & ~(oper1[2] & ~carry[2]))) & (((~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2]) & ((~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2]) & (oper1[2] & ~carry[2]))) & (~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2]))) ^ (((((oper2[2] & ~carry[2]) & (~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2])) & (~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2])) & (~((~oper1[2] & oper2[2]) | (~oper2[2] & oper1[2])) | ~carry[2])) & ((carry[2] | (~(oper2[2] & ~carry[2]) & (oper1[2] & ~carry[2]))) | ((oper2[2] & ~carry[2]) & ~(oper1[2] & ~carry[2])))));
  assign carry[3] = (((((prop[2] & prop[1]) & carry[0]) & prop[0]) | ((gen[1] | gen[2]) & (prop[2] | gen[2]))) | (((prop[2] & prop[1]) & carry[0]) & prop[0])) | (prop[2] & ((carry[0] & (prop[0] & prop[1])) | ((prop[2] & prop[1]) & gen[0])));
  assign gen[3] = oper2[3] & oper1[3];
  assign prop[3] = oper2[3] | oper1[3];
  assign sum[3] = (carry[3] | ((((~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3])))) & ((~carry[3] & oper2[3]) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3])))))) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3]))))) ^ ((((oper1[3] & ~carry[3]) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3]))))) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3]))))) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3]))))))) & (~carry[3] | ~((~oper1[3] | (oper1[3] & ~oper2[3])) & (oper2[3] | (oper1[3] & ~oper2[3]))));
  assign carry[4] = (((gen[2] | gen[3]) | (prop[1] & (prop[3] & (gen[0] & prop[2])))) | (((((prop[2] & prop[1]) & carry[0]) & prop[0]) | ((gen[1] & prop[2]) & prop[3])) & prop[3])) & (prop[3] | ((prop[1] & (prop[3] & (gen[0] & prop[2]))) | (gen[3] | (gen[2] & prop[3]))));
  assign cout = carry[4];
endmodule

