
module SP_rf_LUT_RAM(clk,we,wa,di,re,do0,do1,do2,do3,do4,do5,do6,do7,do8,do9,do10);

  parameter  depth = 11;
  parameter  width = 16;
  parameter  addr_width = 4;
  input  clk;
  input  we;
  input  [addr_width+(-1):0] wa;
  input  [(-1)+width:0] di;
  input  re;
  output [(-1)+width:0] do0;
  output [(-1)+width:0] do1;
  output [(-1)+width:0] do2;
  output [(-1)+width:0] do3;
  output [(-1)+width:0] do4;
  output [(-1)+width:0] do5;
  output [(-1)+width:0] do6;
  output [(-1)+width:0] do7;
  output [(-1)+width:0] do8;
  output [(-1)+width:0] do9;
  output [(-1)+width:0] do10;
  reg  [(-1)+width:0] ram[(-1)+depth:0];

  
  always @(posedge clk)
      begin
        if (we) ram[wa] <= di;
          
      end
  assign do0 = re ? ram[0] : 16'hxxxx;
  assign do1 = re ? ram[1] : 16'hxxxx;
  assign do2 = re ? ram[1<<<1] : 16'hxxxx;
  assign do3 = re ? ram[3] : 16'hxxxx;
  assign do4 = re ? ram[4] : 16'hxxxx;
  assign do5 = re ? ram[5] : 16'hxxxx;
  assign do6 = re ? ram[6] : 16'hxxxx;
  assign do7 = re ? ram[7] : 16'hxxxx;
  assign do8 = re ? ram[8] : 16'hxxxx;
  assign do9 = re ? ram[9] : 16'hxxxx;
  assign do10 = re ? ram[10] : 16'hxxxx;
endmodule

