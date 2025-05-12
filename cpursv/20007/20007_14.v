
module EG_LOGIC_MULT(output [(-1)+OUTPUT_WIDTH:0] p,
                     input  [INPUT_WIDTH_A-1:0] a,
                     input  [INPUT_WIDTH_B-1:0] b,
                     input  cea,
                     input  ceb,
                     input  cepd,
                     input  clk,
                     input  rstan,
                     input  rstbn,
                     input  rstpdn);

  parameter  INPUT_WIDTH_A = 18;
  parameter  INPUT_WIDTH_B = 18;
  parameter  OUTPUT_WIDTH = 36;
  parameter  INPUTFORMAT = SIGNED;
  parameter  INPUTREGA = ENABLE;
  parameter  INPUTREGB = ENABLE;
  parameter  OUTPUTREG = ENABLE;
  parameter  SRMODE = ASYNC;
  parameter  IMPLEMENT = AUTO;


endmodule

