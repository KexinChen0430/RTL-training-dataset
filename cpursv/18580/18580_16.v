
module FixedRoundUnsigned(clk,fixed_num,rounded_num);

  parameter  num_width = 42;
  parameter  fixed_pos = 16;
  input  clk;
  input  [(0-1)+num_width:0] fixed_num;
  output [((0-1)+num_width)+(0-fixed_pos):0] rounded_num;
  reg  [((0-1)+num_width)+(0-fixed_pos):0] reg_rounded_num;

  assign rounded_num = reg_rounded_num;
  
  always @(posedge clk)
      reg_rounded_num <= (fixed_num[fixed_pos-1] == 0) ? fixed_num[(0-1)+num_width:fixed_pos] : (fixed_num[(0-1)+num_width:fixed_pos]+1);
endmodule

