
module myRAM_WxD_D(D,WE,clk,AW,AR,QW,QR);

  parameter  DATA_WIDTH = 16;
  parameter  DATA_DEPTH = 4;
  parameter  DATA_2DEPTH = (-1)+(1<<<1**DATA_DEPTH);
  input  [DATA_WIDTH-1:0] D;
  input  WE,clk;
  input  [(-1)+DATA_DEPTH:0] AW;
  input  [(-1)+DATA_DEPTH:0] AR;
  output [DATA_WIDTH-1:0] QW;
  output [DATA_WIDTH-1:0] QR;
  reg  [DATA_WIDTH-1:0] ram[0:DATA_2DEPTH];

  
  always @(posedge clk)  if (WE) ram[AW] <= D;
    
  assign QW = ram[AW];
  assign QR = ram[AR];
endmodule

