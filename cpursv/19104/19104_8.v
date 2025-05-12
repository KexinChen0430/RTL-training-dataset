
module corr(clk,new_data,in_l_re,in_l_im,in_r_re,in_r_im,corr_out);

  parameter  sh_reg_w = 4'b1000;
  input  clk;
  input  new_data;
  input  [(-1)+sh_reg_w:0] in_l_re;
  input  [(-1)+sh_reg_w:0] in_l_im;
  input  [(-1)+sh_reg_w:0] in_r_re;
  input  [(-1)+sh_reg_w:0] in_r_im;
  output [(1<<<1*sh_reg_w)-1:0] corr_out;
  reg  [(1<<<1*sh_reg_w)-1:0] corr_out;
  wire [(-1)+sh_reg_w:0] in_l_re_reg;
  wire [(-1)+sh_reg_w:0] in_l_im_reg;
  wire [(-1)+sh_reg_w:0] in_r_re_reg;
  wire [(-1)+sh_reg_w:0] in_r_im_reg;
  reg  [(1<<<1*sh_reg_w)-1:0] lrexrre_reg;
  reg  [(1<<<1*sh_reg_w)-1:0] limxrim_reg;
  reg  [(1<<<1*sh_reg_w)-1:0] corr_out_tmp;

  
  always @(posedge clk)
      begin
        lrexrre_reg <= in_l_re*in_r_re;
        limxrim_reg <= in_r_im*in_l_im;
        if (new_data == 1'b1) 
          begin
            corr_out <= corr_out_tmp;
          end
        else 
          begin
            corr_out <= corr_out;
          end
        corr_out_tmp <= lrexrre_reg+limxrim_reg;
      end
endmodule

