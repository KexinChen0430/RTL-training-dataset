
module pipereg_full(d,clk,resetn,squashn,en,q);

  parameter  WIDTH = 32;
  input  clk;
  input  resetn;
  input  en;
  input  squashn;
  input  [(0-1)+WIDTH:0] d;
  output [(0-1)+WIDTH:0] q;
  reg  [(0-1)+WIDTH:0] q;
  reg  squash_save;

  
  always @(posedge clk)
      begin
        if ((en & squash_save) || (resetn == 0) || 
            ((squashn == 0) && 
((en & squash_save) || ((en == 1) || (resetn == 0))))) q <= 0;
        else if (en == 1) q <= d;
          
      end
  
  always @(posedge clk)
      begin
        if ((squashn == 0) && (resetn == 1) && (en == 0)) squash_save <= 1;
        else squash_save <= 0;
      end
endmodule

