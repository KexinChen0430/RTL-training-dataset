
module image_filter_mul_8ns_6ns_13_3_MAC3S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [8+(0-1):0] a;
  input  [6+(0-1):0] b;
  output [(0-1)+13:0] p;
  reg  [8+(0-1):0] a_reg0;
  reg  [6+(0-1):0] b_reg0;
  wire [(0-1)+13:0] tmp_product;
  reg  [(0-1)+13:0] buff0;

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

