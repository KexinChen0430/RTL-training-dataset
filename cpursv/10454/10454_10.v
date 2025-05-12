
module multiplier(clk,reset,x,y,prod,ready);

  parameter  bits = 8;
  input  clk;
  input  reset;
  input  [(-1)+bits:0] x;
  input  [(-1)+bits:0] y;
  output reg [(-1)+(1<<<1*bits):0] prod;
  output reg ready;
  reg  [7:0] rx;
  reg  [15:0] ry;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            rx <= x;
            ry <= y+16'b0;
            prod <= 16'b0;
          end
        else 
          begin
            rx <= rx>>1;
            ry <= 1<<<1*ry;
            if (rx & 8'b1) 
              begin
                prod <= prod+ry;
              end
            else 
              begin
                prod <= prod;
              end
          end
        ready <= !rx || !ry;
      end
endmodule

