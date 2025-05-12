
module CC_MULT  #(parameter  A_WIDTH = 0, B_WIDTH = 0, P_WIDTH = 0)
  (input  signed  [A_WIDTH+(0-1):0] A,
   input  signed  [(0-1)+B_WIDTH:0] B,
   output reg signed  [(0-1)+P_WIDTH:0] P);

  
  always @(*)  begin
    P <= B*A;
  end
endmodule

