
module image_filter_mul_8ns_25ns_32_3_MAC3S_1(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [8+(0-1):0] a;
  input  [(0-1)+25:0] b;
  output [(0-1)+32:0] p;
  reg  [8+(0-1):0] a_reg0;
  reg  [(0-1)+25:0] b_reg0;
  wire [(0-1)+32:0] tmp_product;
  reg  [(0-1)+32:0] buff0;

  assign p = buff0;
  assign tmp_product = a_reg0*b_reg0;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            a_reg0 <= a;
            b_reg0 <= b;
            buff0 <= tmp_product;
          end
          
      end
endmodule

