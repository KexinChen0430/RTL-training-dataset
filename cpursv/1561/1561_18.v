
module lens_flat_line(pclk,first,next,F0,ERR0,A0,B0,F,ERR);

  parameter  F_WIDTH = 18;
  parameter  F_SHIFT = 22;
  parameter  B_SHIFT = 12;
  parameter  A_WIDTH = 18;
  parameter  B_WIDTH = 21;
  parameter  DF_WIDTH = (-F_SHIFT)+(B_SHIFT+B_WIDTH);
  input  pclk;
  input  first;
  input  next;
  input  [(0-1)+F_WIDTH:0] F0;
  input  [1+F_SHIFT:0] ERR0;
  input  [A_WIDTH-1:0] A0;
  input  [B_WIDTH-1:0] B0;
  output [(0-1)+F_WIDTH:0] F;
  output [1+F_SHIFT:0] ERR;
  reg  [1+F_SHIFT:0] ERR;
  reg  [1+F_SHIFT:0] ApB;
  reg  [1+F_SHIFT:1] A2X;
  reg  [(0-1)+DF_WIDTH:0] dF;
  reg  [(0-1)+F_WIDTH:0] F;
  reg  next_d,first_d;
  reg  [(0-1)+F_WIDTH:0] F1;
  reg  [A_WIDTH-1:0] A;
  wire [1+F_SHIFT:0] 
       preERR = ({A2X[1+F_SHIFT:1],1'b0}+ApB[1+F_SHIFT:0])-{dF[1:0],{F_SHIFT{1'b0}}};
  wire [1:0] 
       inc = {((preERR[1+F_SHIFT] & ~preERR[F_SHIFT]) | ~preERR[F_SHIFT-1]) & preERR[1+F_SHIFT],(preERR[1+F_SHIFT:F_SHIFT-1] != 3'h0) & (preERR[1+F_SHIFT:F_SHIFT-1] != 3'h7)};

  
  always @(posedge pclk)
      begin
        first_d <= first;
        next_d <= next;
        if (first) 
          begin
            F1[(0-1)+F_WIDTH:0] <= F0[(0-1)+F_WIDTH:0];
            dF[(0-1)+DF_WIDTH:0] <= B0[B_WIDTH-1:(0-B_SHIFT)+F_SHIFT];
            ERR[1+F_SHIFT:0] <= ERR0[1+F_SHIFT:0];
            ApB[1+F_SHIFT:0] <= {{(1+F_SHIFT)+((-A_WIDTH)+1){A0[A_WIDTH-1]}},A0[A_WIDTH-1:0]}+{B0[B_WIDTH-1:0],{(0-B_SHIFT)+F_SHIFT{1'b0}}};
            A[A_WIDTH-1:0] <= A0[A_WIDTH-1:0];
          end
        else if (next) 
          begin
            dF[(0-1)+DF_WIDTH:0] <= dF[(0-1)+DF_WIDTH:0]+{{(0-1)+DF_WIDTH{inc[1]}},inc[1:0]};
            ERR[F_SHIFT-1:0] <= preERR[F_SHIFT-1:0];
            ERR[1+F_SHIFT:F_SHIFT] <= preERR[1+F_SHIFT:F_SHIFT]-inc[1:0];
          end
          
        if (first_d) F[(0-1)+F_WIDTH:0] <= F1[(0-1)+F_WIDTH:0];
        else if (next_d) 
          F[(0-1)+F_WIDTH:0] <= {{F_WIDTH-DF_WIDTH{dF[(0-1)+DF_WIDTH]}},dF[(0-1)+DF_WIDTH:0]}+F[(0-1)+F_WIDTH:0];
          
        if (first_d) 
          A2X[1+F_SHIFT:1] <= {{(1+F_SHIFT)+((-A_WIDTH)+1){A[A_WIDTH-1]}},A[A_WIDTH-1:0]};
        else if (next) 
          A2X[1+F_SHIFT:1] <= A2X[1+F_SHIFT:1]+{{(1+F_SHIFT)+((-A_WIDTH)+1){A[A_WIDTH-1]}},A[A_WIDTH-1:0]};
          
      end
endmodule

