
module FixedRoundSigned(clk,fixed_num,round);

  parameter  num_width = 42;
  parameter  fixed_pos = 16;
  parameter  res_width = 12;
  input  clk;
  input  signed  [num_width-1:0] fixed_num;
  output reg signed  [res_width:0] round;
  reg  signed  [num_width-1:0] num_orig;
  reg  num_orig_sflag,num_orig_rflag;
  reg  signed  [res_width:0] num_comp;

  
  always @(posedge clk)
      begin
        num_orig <= (fixed_num[num_width-1] == 0) ? fixed_num : {fixed_num[num_width-1],~((-1)+fixed_num[num_width-2:0])};
        num_comp <= (num_orig[num_width-1] == 0) ? {num_orig[num_width-1],num_orig[((-1)+fixed_pos)+res_width:fixed_pos]} : {num_orig[num_width-1],1+~num_orig[((-1)+fixed_pos)+res_width:fixed_pos]};
        num_orig_sflag <= num_orig[num_width-1];
        num_orig_rflag <= num_orig[(-1)+fixed_pos];
        case (num_orig_sflag)

          0: round <= (num_orig_rflag == 0) ? num_comp : (1+num_comp);

          1: round <= (num_orig_rflag == 0) ? num_comp : (num_comp+(-1));

          default:  ;

        endcase

      end
endmodule

