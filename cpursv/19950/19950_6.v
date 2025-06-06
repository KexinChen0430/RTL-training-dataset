
module pipedelayreg(d,en,clk,resetn,squashn,dst,stalled,q);

  parameter  WIDTH = 32;
  input  [(-1)+WIDTH:0] d;
  input  [4:0] dst;
  input  en;
  input  clk;
  input  resetn;
  input  squashn;
  output stalled;
  output [(-1)+WIDTH:0] q;
  reg  [(-1)+WIDTH:0] q;
  reg  T,Tnext;

  
  always @(en or T or dst)
      begin
        case (T)

          0: Tnext = en & |dst;

          1: Tnext = 0;

        endcase

      end
  
  always @(posedge clk)
      if (~resetn) T <= 0;
      else T <= Tnext;
  
  always @(posedge clk)
      begin
        if ((squashn == 0) || (resetn == 0)) q <= 0;
        else if (en == 1) q <= d;
          
      end
  assign stalled = (~T & en) & |dst;
endmodule

