module divider (
  rfd, rdy, divide_by_zero, nd, clk, dividend, quotient, divisor, fractional
);
  output reg rfd;
  output reg rdy;
  output reg divide_by_zero;
  input nd;
  input clk;
  input [3 : 0] dividend;
  output reg [3 : 0] quotient;
  input [31 : 0] divisor;
  output reg [31 : 0] fractional;
  wire signed [63:0]  dend = {28'b0, dividend, 32'b0};
  wire signed [63:0]  dsor = {{32{divisor[31]}}, divisor};
 wire signed [63:0]  result = dend/dsor;
 reg signed [63:0] result_save;
 initial
  begin
    rfd <= 1;
    rdy <= 0;
    divide_by_zero <= 0;
  end
  always @(posedge clk)
  begin
      rdy <= 0;
    if (nd)
    begin
      rfd <= 0;
      result_save <= result;
      repeat (10) @(posedge clk);
      #1;
      quotient <= result_save[35:32];
      fractional <= result_save[31:0];
      rdy <= 1;
      rfd <= 1;
    end
  end
endmodule