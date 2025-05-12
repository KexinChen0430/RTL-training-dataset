
module signed_mult(A,B,Valid,C);

  parameter  WIDTH = 32;
  parameter  CWIDTH = 1<<<1*WIDTH;
  input  [(-1)+WIDTH:0] A,B;
  input  Valid;
  output [(-1)+CWIDTH:0] C;
  reg  signed  [(-1)+WIDTH:0] A_q,B_q;
  wire signed  [(-1)+CWIDTH:0] C_int;

  assign C_int = B_q*A_q;
  assign valid_int = Valid;
  assign C = C_int;
  
  always @(*)
      if (valid_int == 1'b1) A_q <= A;
        
  
  always @(*)
      if (valid_int == 1'b1) B_q <= B;
        
endmodule

