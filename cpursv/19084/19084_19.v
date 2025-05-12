
module corr_seq(clk,new_data,in_l_re,in_l_im,in_r_re,in_r_im,corr_out);

  parameter  sh_reg_w = 4'b1000;
  input  clk;
  input  new_data;
  input  [(0-1)+sh_reg_w:0] in_l_re;
  input  [(0-1)+sh_reg_w:0] in_l_im;
  input  [(0-1)+sh_reg_w:0] in_r_re;
  input  [(0-1)+sh_reg_w:0] in_r_im;
  output [(0-1)+sh_reg_w<<1:0] corr_out;
  reg  [(0-1)+sh_reg_w<<1:0] corr_out;
  reg  [(0-1)+sh_reg_w:0] in_l_re_reg;
  reg  [(0-1)+sh_reg_w:0] in_l_im_reg;
  reg  [(0-1)+sh_reg_w:0] in_r_re_reg;
  reg  [(0-1)+sh_reg_w:0] in_r_im_reg;
  reg  [(0-1)+sh_reg_w<<1:0] lrexrre_reg;
  reg  [(0-1)+sh_reg_w<<1:0] limxrim_reg;
  reg  [(0-1)+sh_reg_w<<1:0] corr_out_tmp;

  
  always @(posedge clk)
      begin
        if (new_data == 1'b1) 
          begin
            in_l_re_reg <= in_l_re;
            in_l_im_reg <= in_l_im;
            in_r_re_reg <= in_r_re;
            in_r_im_reg <= in_r_im;
            corr_out <= corr_out_tmp;
          end
        else 
          begin
            in_l_re_reg <= in_l_re_reg;
            in_l_im_reg <= in_l_im_reg;
            in_r_re_reg <= in_r_re_reg;
            in_r_im_reg <= in_r_im_reg;
            corr_out <= corr_out;
          end
        lrexrre_reg <= in_l_re_reg*in_r_re_reg;
        limxrim_reg <= in_r_im_reg*in_l_im_reg;
        corr_out_tmp <= limxrim_reg+lrexrre_reg;
      end
endmodule

