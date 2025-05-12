
module regfile1(clk,x,ld,r,r);

  parameter  n = 16;
  input  clk;
  input  [n+(-1):0] x;
  input  ld;
  output reg [n+(-1):0] r;

  
  always @(posedge clk)
      begin
        if (ld) 
          begin
            r <= x;
          end
        else 
          begin
            r <= r;
          end
      end
endmodule

