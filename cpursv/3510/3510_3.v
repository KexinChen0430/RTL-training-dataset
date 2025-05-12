
module regfile1(clk,x,ld,r,r);

  parameter  n = 16;
  input  clk;
  input  [(0-1)+n:0] x;
  input  ld;
  output reg [(0-1)+n:0] r;

  
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

