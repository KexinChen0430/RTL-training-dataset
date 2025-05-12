
module fulladder(in1,in2,cin,sum,cout);

  input  wire in1,in2,cin;
  output wire sum,cout;

  assign sum = (cin & ~(((~in1 & (in1 | in2)) & in2) | ((~in2 | (~in1 & (in1 | in2))) & in1))) | (((in2 & ((~(in2 & ~cin) & (in1 & ~cin)) | (((in2 & ~(in1 & ~cin)) & ~cin) | ~(((~in1 & (in1 | in2)) & in2) | ((~in2 | (~in1 & (in1 | in2))) & in1))))) & ~cin) ^ ((in1 & ((~(in2 & ~cin) & (in1 & ~cin)) | (((in2 & ~(in1 & ~cin)) & ~cin) | ~(((~in1 & (in1 | in2)) & in2) | ((~in2 | (~in1 & (in1 | in2))) & in1))))) & ~cin));
  assign cout = (in1 | ((in2 & in1) | (cin & in2))) & (cin | in2);
endmodule

