
module pipereg_w5(clk,resetn,d,squashn,en,q);

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
        else if (en == 1) 
          begin
            q[4:0] <= d;
            q[31:5] <= 0;
          end
          
      end
endmodule

