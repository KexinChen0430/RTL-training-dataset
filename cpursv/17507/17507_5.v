
module pipedelayreg(d,en,clk,resetn,squashn,dst,stalled,q);

  input  [31:0] d;
  input  [4:0] dst;
  input  en;
  input  clk;
  input  resetn;
  input  squashn;
  output stalled;
  output [31:0] q;
  reg  [31:0] q;
  reg  T,Tnext;

  
  always @(en or T or dst)
      begin
        case (T)

          0: Tnext = |dst & en;

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
  assign stalled = (|dst & ~T) & en;
endmodule

