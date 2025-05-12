
module CC_MULT  #(parameter  A_WIDTH = 0, B_WIDTH = 0, P_WIDTH = 0)
  (input  signed  [(-1)+A_WIDTH:0] A,
   input  signed  [B_WIDTH+(-1):0] B,
   output reg signed  [P_WIDTH+(-1):0] P);

  
  always @(*)  begin
    P <= B*A;
  end
endmodule

