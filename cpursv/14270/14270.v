
module one_register(dataa,result);

  input  clk;
  input  clk_ena;
  input  [17:0] dataa;
  output [17:0] result;

  assign result = dataa;
endmodule

