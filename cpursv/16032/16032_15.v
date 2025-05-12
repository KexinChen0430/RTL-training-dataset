
module halfadder(in1,in2,sum,cout);

  input  wire in1,in2;
  output wire sum,cout;

  assign sum = ((in2 & in1) ^ in2) | (in1 ^ (in2 & in1));
  assign cout = in2 & in1;
endmodule

