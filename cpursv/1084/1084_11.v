
module video_scaler_mul_jbC_MulnS_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [(0-1)+32:0] a;
  input  [16+(0-1):0] b;
  output [(0-1)+32:0] p;
  reg  signed  [(0-1)+32:0] a_reg0;
  reg  signed  [16+(0-1):0] b_reg0;
  wire signed  [(0-1)+32:0] tmp_product;
  reg  signed  [(0-1)+32:0] buff0;

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

