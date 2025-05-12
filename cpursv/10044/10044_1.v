
module RevertReg(CLK,Q_OUT,D_IN,EN);

  parameter  width = 1;
  parameter  init = {width{1'b0}};
  input  CLK;
  input  EN;
  input  [(0-1)+width:0] D_IN;
  output [(0-1)+width:0] Q_OUT;

  assign Q_OUT = init;
endmodule

