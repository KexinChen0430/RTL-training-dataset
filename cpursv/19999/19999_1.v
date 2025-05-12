
module pipereg(d,clk,resetn,en,squashn,q);

  parameter  WIDTH = 32;
  input  clk;
  input  resetn;
  input  en;
  input  squashn;
  input  [WIDTH-1:0] d;
  output [WIDTH-1:0] q;
  reg  [WIDTH-1:0] q;

  
  always @(posedge clk)
      begin
        if ((squashn == 0) || (resetn == 0)) q <= 0;
        else if (en == 1) q <= d;
          
      end
endmodule

