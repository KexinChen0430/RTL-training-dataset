
module lens_flat_line(pclk,first,next,F0,ERR0,A0,B0,F,ERR);

  parameter  F_WIDTH = 18;
  parameter  F_SHIFT = 22;
  parameter  B_SHIFT = 12;
  parameter  A_WIDTH = 18;
  parameter  B_WIDTH = 21;
  parameter  DF_WIDTH = (B_SHIFT+B_WIDTH)+(-F_SHIFT);
  input  pclk;
  input  first;
  input  next;
  input  [(-1)+F_WIDTH:0] F0;
  input  [F_SHIFT+1:0] ERR0;
  input  [A_WIDTH-1:0] A0;
  input  [B_WIDTH+(-1):0] B0;
  output [(-1)+F_WIDTH:0] F;
  output [F_SHIFT+1:0] ERR;
  reg  [F_SHIFT+1:0] ERR;
  reg  [F_SHIFT+1:0] ApB;
  reg  [F_SHIFT+1:1] A2X;
  reg  [DF_WIDTH+(-1):0] dF;
  reg  [(-1)+F_WIDTH:0] F;
  reg  next_d,first_d;
  reg  [(-1)+F_WIDTH:0] F1;
  reg  [A_WIDTH-1:0] A;
  wire [F_SHIFT+1:0] 
       preERR = ApB[F_SHIFT+1:0]+((0-{dF[1:0],{F_SHIFT{1'b0}}})+{A2X[F_SHIFT+1:1],1'b0});
  wire [1:0] 
       inc = {preERR[F_SHIFT+1] & (~preERR[F_SHIFT+(-1)] | ~preERR[F_SHIFT]),(preERR[F_SHIFT+1:F_SHIFT+(-1)] != 3'h7) & (preERR[F_SHIFT+1:F_SHIFT+(-1)] != 3'h0)};

  
  always @(posedge pclk)
      begin
        first_d <= first;
        next_d <= next;
        if (first) 
          begin
            F1[(-1)+F_WIDTH:0] <= F0[(-1)+F_WIDTH:0];
            dF[DF_WIDTH+(-1):0] <= B0[B_WIDTH+(-1):F_SHIFT-B_SHIFT];
            ERR[F_SHIFT+1:0] <= ERR0[F_SHIFT+1:0];
            ApB[F_SHIFT+1:0] <= {{1<<<1+((0-A_WIDTH)+F_SHIFT){A0[A_WIDTH-1]}},A0[A_WIDTH-1:0]}+{B0[B_WIDTH+(-1):0],{F_SHIFT-B_SHIFT{1'b0}}};
            A[A_WIDTH-1:0] <= A0[A_WIDTH-1:0];
          end
        else if (next) 
          begin
            dF[DF_WIDTH+(-1):0] <= {{DF_WIDTH+(-1){inc[1]}},inc[1:0]}+dF[DF_WIDTH+(-1):0];
            ERR[F_SHIFT+(-1):0] <= preERR[F_SHIFT+(-1):0];
            ERR[F_SHIFT+1:F_SHIFT] <= preERR[F_SHIFT+1:F_SHIFT]+(0-inc[1:0]);
          end
          
        if (first_d) F[(-1)+F_WIDTH:0] <= F1[(-1)+F_WIDTH:0];
        else if (next_d) 
          F[(-1)+F_WIDTH:0] <= {{F_WIDTH-DF_WIDTH{dF[DF_WIDTH+(-1)]}},dF[DF_WIDTH+(-1):0]}+F[(-1)+F_WIDTH:0];
          
        if (first_d) 
          A2X[F_SHIFT+1:1] <= {{1<<<1+((0-A_WIDTH)+F_SHIFT){A[A_WIDTH-1]}},A[A_WIDTH-1:0]};
        else if (next) 
          A2X[F_SHIFT+1:1] <= {{1<<<1+((0-A_WIDTH)+F_SHIFT){A[A_WIDTH-1]}},A[A_WIDTH-1:0]}+A2X[F_SHIFT+1:1];
          
      end
endmodule

