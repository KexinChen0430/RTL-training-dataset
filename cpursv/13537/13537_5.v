
module techlib_dff(CLK,D,Q);

  parameter  WIDTH = 0;
  parameter  CLK_POLARITY = 1'b1;
  input  CLK;
  input  [WIDTH+(0-1):0] D;
  output reg [WIDTH+(0-1):0] Q;
  wire  pos_clk = CLK == CLK_POLARITY;

  
  always @(posedge pos_clk)  begin
    Q <= D;
  end
endmodule

