
module fulladder(in1,in2,cin,sum,cout);

  input  wire in1,in2,cin;
  output wire sum,cout;

  assign sum = ((in2 | in1) & (((in2 & ~in1) | ~in2) & ~cin)) | (cin & ~(in1 ^ in2));
  assign cout = ((cin | in1) & in2) | ((in1 & (cin | in2)) & cin);
endmodule

