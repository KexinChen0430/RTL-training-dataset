
module techlib_dffe(CLK,EN,D,Q);

  parameter  WIDTH = 0;
  parameter  CLK_POLARITY = 1'b1;
  parameter  EN_POLARITY = 1'b1;
  input  CLK,EN;
  input  [WIDTH+(0-1):0] D;
  output reg [WIDTH+(0-1):0] Q;
  wire  pos_clk = CLK == CLK_POLARITY;

  
  always @(posedge pos_clk)
      begin
        if (EN == EN_POLARITY) Q <= D;
          
      end
endmodule

