
module corr(clk,new_data,in_l_re,in_l_im,in_r_re,in_r_im,corr_out);

  parameter  sh_reg_w = 4'b1000;
  input  clk;
  input  new_data;
  input  [sh_reg_w-1:0] in_l_re;
  input  [sh_reg_w-1:0] in_l_im;
  input  [sh_reg_w-1:0] in_r_re;
  input  [sh_reg_w-1:0] in_r_im;
  output [sh_reg_w<<1+(0-1):0] corr_out;
  reg  [sh_reg_w<<1+(0-1):0] corr_out;
  wire [sh_reg_w-1:0] in_l_re_reg;
  wire [sh_reg_w-1:0] in_l_im_reg;
  wire [sh_reg_w-1:0] in_r_re_reg;
  wire [sh_reg_w-1:0] in_r_im_reg;
  reg  [sh_reg_w<<1+(0-1):0] lrexrre_reg;
  reg  [sh_reg_w<<1+(0-1):0] limxrim_reg;
  reg  [sh_reg_w<<1+(0-1):0] corr_out_tmp;

  
  always @(posedge clk)
      begin
        lrexrre_reg <= in_l_re*in_r_re;
        limxrim_reg <= in_l_im*in_r_im;
        if (new_data == 1'b1) 
          begin
            corr_out <= corr_out_tmp;
          end
        else 
          begin
            corr_out <= corr_out;
          end
        corr_out_tmp <= limxrim_reg+lrexrre_reg;
      end
endmodule

