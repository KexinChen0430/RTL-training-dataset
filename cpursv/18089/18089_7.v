
module mul_unsigned_sync(clk,rst,en,a,b,p);

  parameter  M = 6;
  parameter  N = 3;
  input  wire clk,rst,en;
  input  wire [(-1)+M:0] a;
  input  wire [N-1:0] b;
  output reg [(N-1)+M:0] p;
  reg  [(-1)+M:0] a_reg;
  reg  [N-1:0] b_reg;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            a_reg <= 0;
            b_reg <= 0;
            p <= 0;
          end
        else if (en) 
          begin
            a_reg <= a;
            b_reg <= b;
            p <= b_reg*a_reg;
          end
          
      end
endmodule

