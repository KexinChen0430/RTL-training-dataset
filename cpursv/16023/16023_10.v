
module fulladder(in1,in2,cin,sum,cout);

  input  wire in1,in2,cin;
  output wire sum,cout;

  assign sum = ((cin | ((~in1 & (in2 | in1)) | (~in2 & in1))) & (~cin | cin)) & (~cin | ~((~in1 & (in2 | in1)) | (~in2 & in1)));
  assign cout = (in1 & ((cin | in1) & in2)) | (((in1 & cin) | in2) & cin);
endmodule

