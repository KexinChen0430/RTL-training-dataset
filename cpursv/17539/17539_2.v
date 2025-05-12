
module pipereg_w32(clk,resetn,d,squashn,en,q);

  input  clk;
  input  resetn;
  input  en;
  input  squashn;
  input  [31:0] d;
  output [31:0] q;
  reg  [31:0] q;

  
  always @(posedge clk)
      begin
        if ((squashn == 0) || (resetn == 0)) q <= 0;
        else if (en == 1) q <= d;
          
      end
endmodule

