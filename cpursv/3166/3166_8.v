
module myRAM_WxD_D_1(D,WE,clk,AW,AR,QW,QR);

  parameter  DATA_WIDTH = 16;
  parameter  DATA_DEPTH = 4;
  parameter  DATA_2DEPTH = (1<<1**DATA_DEPTH)+(-1);
  input  [(-1)+DATA_WIDTH:0] D;
  input  WE,clk;
  input  [(-1)+DATA_DEPTH:0] AW;
  input  [(-1)+DATA_DEPTH:0] AR;
  output [(-1)+DATA_WIDTH:0] QW;
  output [(-1)+DATA_WIDTH:0] QR;
  reg  [(-1)+DATA_WIDTH:0] ram[0:DATA_2DEPTH];

  
  always @(negedge clk)  if (WE) ram[AW] <= D;
    
  assign QW = ram[AW];
  assign QR = ram[AR];
endmodule

