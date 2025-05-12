
module adder_with_1_reg(dataa,datab,result);

  input  clk;
  input  clk_ena;
  input  [17:0] dataa;
  input  [17:0] datab;
  output [17:0] result;

  assign result = datab+dataa;
endmodule

