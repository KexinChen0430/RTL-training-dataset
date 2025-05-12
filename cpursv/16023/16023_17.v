
module fulladder(in1,in2,cin,sum,cout);

  input  wire in1,in2,cin;
  output wire sum,cout;

  assign sum = ((~cin & ((~cin | (~((~in1 | (~in2 & in1)) & (in2 | in1)) & cin)) & in1)) ^ (~cin & (in2 & (~cin | (~((~in1 | (~in2 & in1)) & (in2 | in1)) & cin))))) | (~((~in1 | (~in2 & in1)) & (in2 | in1)) & ((cin | (~cin & (in2 & ~(in1 & ~cin)))) | ((~cin & ~(~cin & in2)) & in1)));
  assign cout = (in2 | (cin & in1)) & ((in1 & in2) | cin);
endmodule

