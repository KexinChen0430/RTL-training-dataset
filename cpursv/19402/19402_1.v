
module FixedRoundSigned1(clk,fixed_num,round,overflow);

  parameter  num_width = 42;
  parameter  fixed_pos = 16;
  parameter  res_width = 12;
  input  clk;
  input  signed  [(-1)+num_width:0] fixed_num;
  output reg signed  [res_width:0] round;
  output reg overflow;
  reg  signed  [(-1)+num_width:0] num_orig;
  reg  num_orig_sflag,num_orig_rflag,reg_overflow;
  reg  signed  [res_width:0] num_comp;

  
  always @(posedge clk)
      begin
        num_orig <= (fixed_num[(-1)+num_width] == 0) ? fixed_num : {fixed_num[(-1)+num_width],~((-1)+fixed_num[(0-2)+num_width:0])};
        num_comp <= (num_orig[(-1)+num_width] == 0) ? {num_orig[(-1)+num_width],num_orig[(-1)+(fixed_pos+res_width):fixed_pos]} : {num_orig[(-1)+num_width],~num_orig[(-1)+(fixed_pos+res_width):fixed_pos]+1};
        reg_overflow <= (num_orig[(0-2)+num_width:fixed_pos+res_width] == 0) ? 0 : 1;
        overflow <= reg_overflow;
        num_orig_sflag <= num_orig[(-1)+num_width];
        num_orig_rflag <= num_orig[fixed_pos+(-1)];
        case (num_orig_sflag)

          0: round <= (num_orig_rflag == 0) ? num_comp : (1+num_comp);

          1: round <= (num_orig_rflag == 0) ? num_comp : (num_comp+(-1));

          default:  ;

        endcase

      end
endmodule

