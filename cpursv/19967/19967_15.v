
module top2(clk,a,b,c,hold);

  parameter  A_WIDTH = 6;
  parameter  B_WIDTH = 6;
  input  hold;
  input  clk;
  input  signed  [A_WIDTH+(-1):0] a;
  input  signed  [(-1)+B_WIDTH:0] b;
  output signed  [B_WIDTH+(A_WIDTH+(-1)):0] c;
  reg  signed  [A_WIDTH+(-1):0] reg_a;
  reg  signed  [(-1)+B_WIDTH:0] reg_b;
  reg  [B_WIDTH+(A_WIDTH+(-1)):0] reg_tmp_c;

  assign c = reg_tmp_c;
  
  always @(posedge clk)
      begin
        if (!hold) 
          begin
            reg_a <= a;
            reg_b <= b;
            reg_tmp_c <= (reg_b*reg_a)+c;
          end
          
      end
endmodule

