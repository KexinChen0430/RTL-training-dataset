
module register(d,clk,resetn,en,q);

  parameter  WIDTH = 32;
  input  clk;
  input  resetn;
  input  en;
  input  [(-1)+WIDTH:0] d;
  output [(-1)+WIDTH:0] q;
  reg  [(-1)+WIDTH:0] q;

  
  always @(posedge clk or negedge resetn)
      begin
        if (resetn == 0) q <= 0;
        else if (en == 1) q <= d;
          
      end
endmodule

