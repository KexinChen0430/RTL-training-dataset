
module jbi_adder_1b(cout,sum,oper1,oper2,cin);

  input  oper1;
  input  oper2;
  input  cin;
  output cout;
  output sum;

  assign sum = ((~((~cin & (cin | oper2)) & oper2) & ~cin) & oper1) | (((~cin & ~(~cin & oper1)) | ((~((~oper2 | (((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1)))))) & ~oper1)) & ((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1))))))) & (cin | oper1)) & cin)) & ((oper2 | (~((~oper2 | (((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1)))))) & ~oper1)) & ((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1))))))) & (cin & oper1))) | ((~((~oper2 | (((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1)))))) & ~oper1)) & ((((cin & oper1) | ((oper2 & oper1) & cin)) | oper2) | (((cin & oper2) | ((oper1 & (~oper2 & (cin | oper1))) & ~oper1)) | (~oper2 & (oper1 & (~oper2 & (cin | oper1))))))) & (cin | oper1)) & cin)));
  assign cout = (((oper2 & oper1) & cin) | (cin & oper1)) | (oper2 & (oper1 | (cin & oper2)));
endmodule

