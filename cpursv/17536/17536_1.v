
module pipereg_w1(clk,resetn,d,squashn,en,q);

  input  clk;
  input  resetn;
  input  en;
  input  squashn;
  input  d;
  output q;
  reg  q;

  
  always @(posedge clk)
      begin
        if ((squashn == 0) || (resetn == 0)) q <= 0;
        else if (en == 1) q <= d;
          
      end
endmodule

