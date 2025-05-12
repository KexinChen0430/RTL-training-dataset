
module pipereg_full(d,clk,resetn,squashn,en,q);

  parameter  WIDTH = 32;
  input  clk;
  input  resetn;
  input  en;
  input  squashn;
  input  [WIDTH+(0-1):0] d;
  output [WIDTH+(0-1):0] q;
  reg  [WIDTH+(0-1):0] q;
  reg  squash_save;

  
  always @(posedge clk)
      begin
        if ((squash_save & en) || 
            (((en == 1) && (squashn == 0)) || (resetn == 0))) q <= 0;
        else if (en == 1) q <= d;
          
      end
  
  always @(posedge clk)
      begin
        if ((resetn == 1) && (squashn == 0) && (en == 0)) squash_save <= 1;
        else squash_save <= 0;
      end
endmodule

