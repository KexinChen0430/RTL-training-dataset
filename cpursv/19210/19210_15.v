
module DW01_add1(A,B,CI,SUM,CO);

  parameter  width = 70;
  output [(-1)+width:0] SUM;
  output CO;
  input  [(-1)+width:0] A;
  input  [(-1)+width:0] B;
  input  CI;
  wire [(-1)+width:0] SUM;
  reg  [(-(1+1))+width:0] sum_temp;
  reg  CO;
  reg  c_out;

  assign SUM = {CO,sum_temp};
  
  always @(A or B or CI)
      begin
        {CO,sum_temp} = CI+(A+B);
      end
endmodule

