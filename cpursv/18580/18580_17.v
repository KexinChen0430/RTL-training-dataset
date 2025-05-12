
module FixedRoundUnsigned(clk,fixed_num,rounded_num);

  parameter  num_width = 42;
  parameter  fixed_pos = 16;
  input  clk;
  input  [num_width-1:0] fixed_num;
  output [((0-1)+(-fixed_pos))+num_width:0] rounded_num;
  reg  [((0-1)+(-fixed_pos))+num_width:0] reg_rounded_num;

  assign rounded_num = reg_rounded_num;
  
  always @(posedge clk)
      reg_rounded_num <= (fixed_num[(0-1)+fixed_pos] == 0) ? fixed_num[num_width-1:fixed_pos] : (fixed_num[num_width-1:fixed_pos]+1);
endmodule

