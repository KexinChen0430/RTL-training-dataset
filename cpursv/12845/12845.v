
module ac97_sout(clk,rst,so_ld,slt0,slt1,slt2,slt3,slt4,slt6,slt7,slt8,slt9,
                 sdata_out);

  input  clk,rst;
  input  so_ld;
  input  [15:0] slt0;
  input  [19:0] slt1;
  input  [19:0] slt2;
  input  [19:0] slt3;
  input  [19:0] slt4;
  input  [19:0] slt6;
  input  [19:0] slt7;
  input  [19:0] slt8;
  input  [19:0] slt9;
  output sdata_out;
  wire sdata_out;
  reg  [15:0] slt0_r;
  reg  [19:0] slt1_r;
  reg  [19:0] slt2_r;
  reg  [19:0] slt3_r;
  reg  [19:0] slt4_r;
  reg  [19:0] slt5_r;
  reg  [19:0] slt6_r;
  reg  [19:0] slt7_r;
  reg  [19:0] slt8_r;
  reg  [19:0] slt9_r;
  reg  [19:0] slt10_r;
  reg  [19:0] slt11_r;
  reg  [19:0] slt12_r;

  assign sdata_out = slt0_r[15];
  
  always @(posedge clk)
      if (so_ld) slt0_r <= #1 slt0;
      else slt0_r <= #1 {slt0_r[14:0],slt1_r[19]};
endmodule

