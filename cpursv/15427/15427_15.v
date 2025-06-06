
module mc_sop1(input  clk,
               input  reset,
               input  [15:0] io_x,
               output [15:0] io_y);

  reg  [15:0] yy;
  wire [15:0] T0;
  wire [23:0] T1;
  wire [31:0] sop;
  reg  [31:0] mults_3;
  wire [31:0] T2;
  reg  [15:0] delays_3;
  reg  [15:0] delays_2;
  reg  [15:0] delays_1;
  reg  [15:0] delays_0;
  wire [31:0] T3;
  reg  [31:0] mults_2;
  wire [31:0] T4;
  wire [31:0] T5;
  reg  [31:0] mults_1;
  wire [31:0] T6;
  reg  [31:0] mults_0;
  wire [31:0] T7;

  assign io_y = yy;
  assign T0 = T1[4'hf:1'h0];
  assign T1 = $signed(sop)>>>$signed(4'h8);
  assign sop = mults_3+T3;
  assign T2 = $signed(16'h40)*$signed(delays_3);
  assign T3 = T5+mults_2;
  assign T4 = $signed(delays_2)*$signed(16'h40);
  assign T5 = mults_1+mults_0;
  assign T6 = $signed(delays_1)*$signed(16'h40);
  assign T7 = $signed(16'h40)*$signed(delays_0);
  
  always @(posedge clk)
      begin
        yy <= reset ? 16'h0 : T0;
        mults_3 <= reset ? 32'h0 : T2;
        delays_3 <= reset ? 16'h0 : delays_2;
        delays_2 <= reset ? 16'h0 : delays_1;
        delays_1 <= reset ? 16'h0 : delays_0;
        delays_0 <= reset ? 16'h0 : io_x;
        mults_2 <= reset ? 32'h0 : T4;
        mults_1 <= reset ? 32'h0 : T6;
        mults_0 <= reset ? 32'h0 : T7;
      end
endmodule

