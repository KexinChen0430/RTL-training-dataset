
module signed_mult(A,B,Valid,C);

  parameter  WIDTH = 32;
  parameter  CWIDTH = WIDTH*1<<<1;
  input  [WIDTH+(-1):0] A,B;
  input  Valid;
  output [(-1)+CWIDTH:0] C;
  reg  signed  [WIDTH+(-1):0] A_q,B_q;
  wire signed  [(-1)+CWIDTH:0] C_int;

  assign C_int = B_q*A_q;
  assign valid_int = Valid;
  assign C = C_int;
  
  always @(*)
      if (valid_int == 1'b1) A_q <= A;
        
  
  always @(*)
      if (valid_int == 1'b1) B_q <= B;
        
endmodule

