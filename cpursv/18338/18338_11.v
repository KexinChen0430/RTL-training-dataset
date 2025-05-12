
module lm32_addsub(DataA,DataB,Cin,Add_Sub,Result,Cout);

  input  [31:0] DataA;
  input  [31:0] DataB;
  input  Cin;
  input  Add_Sub;
  output [31:0] Result;
  wire [31:0] Result;
  output Cout;
  wire Cout;
  wire [32:0]  tmp_addResult = (DataB+DataA)+Cin;
  wire [32:0]  tmp_subResult = (DataA+(0-!Cin))+(0-DataB);

  assign Result = (Add_Sub == 1) ? tmp_addResult[31:0] : tmp_subResult[31:0];
  assign Cout = (Add_Sub == 1) ? tmp_addResult[32] : !tmp_subResult[32];
endmodule

