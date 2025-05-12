
module hls_macc_mul_32s_bkb_MulnS_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [(0-1)+32:0] a;
  input  [(0-1)+32:0] b;
  output [(0-1)+32:0] p;
  reg  signed  [(0-1)+32:0] a_reg0;
  reg  signed  [(0-1)+32:0] b_reg0;
  wire signed  [(0-1)+32:0] tmp_product;
  reg  signed  [(0-1)+32:0] buff0;
  reg  signed  [(0-1)+32:0] buff1;
  reg  signed  [(0-1)+32:0] buff2;
  reg  signed  [(0-1)+32:0] buff3;
  reg  signed  [(0-1)+32:0] buff4;

  assign p = buff4;
  assign tmp_product = b_reg0*a_reg0;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            a_reg0 <= a;
            b_reg0 <= b;
            buff0 <= tmp_product;
            buff1 <= buff0;
            buff2 <= buff1;
            buff3 <= buff2;
            buff4 <= buff3;
          end
          
      end
endmodule

