
module top2(clk,a,b,c,hold);

  parameter  A_WIDTH = 6;
  parameter  B_WIDTH = 6;
  input  hold;
  input  clk;
  input  signed  [(0-1)+A_WIDTH:0] a;
  input  signed  [B_WIDTH+(0-1):0] b;
  output signed  [(A_WIDTH+B_WIDTH)-1:0] c;
  reg  signed  [(0-1)+A_WIDTH:0] reg_a;
  reg  signed  [B_WIDTH+(0-1):0] reg_b;
  reg  [(A_WIDTH+B_WIDTH)-1:0] reg_tmp_c;

  assign c = reg_tmp_c;
  
  always @(posedge clk)
      begin
        if (!hold) 
          begin
            reg_a <= a;
            reg_b <= b;
            reg_tmp_c <= c+(reg_a*reg_b);
          end
          
      end
endmodule

