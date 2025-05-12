
module EG_LOGIC_DRAM16X4(input  [3:0] di,
                         input  [3:0] waddr,
                         input  wclk,
                         input  we,
                         input  [3:0] raddr,
                         output [3:0] do);

  parameter  INIT_D0 = 16'h0000;
  parameter  INIT_D1 = 16'h0000;
  parameter  INIT_D2 = 16'h0000;
  parameter  INIT_D3 = 16'h0000;


endmodule

