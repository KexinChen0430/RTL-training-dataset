
module register_sync(d,clk,resetn,en,q);

  parameter  WIDTH = 32;
  input  clk;
  input  resetn;
  input  en;
  input  [WIDTH+(0-1):0] d;
  output [WIDTH+(0-1):0] q;
  reg  [WIDTH+(0-1):0] q;

  
  always @(posedge clk)
      begin
        if (resetn == 0) q <= 0;
        else if (en == 1) q <= d;
          
      end
endmodule

