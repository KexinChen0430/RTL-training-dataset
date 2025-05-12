
module DW01_add1(A,B,CI,SUM,CO);

  parameter  width = 70;
  output [(0-1)+width:0] SUM;
  output CO;
  input  [(0-1)+width:0] A;
  input  [(0-1)+width:0] B;
  input  CI;
  wire [(0-1)+width:0] SUM;
  reg  [(0-(1+1))+width:0] sum_temp;
  reg  CO;
  reg  c_out;

  assign SUM = {CO,sum_temp};
  
  always @(A or B or CI)
      begin
        {CO,sum_temp} = B+(CI+A);
      end
endmodule

