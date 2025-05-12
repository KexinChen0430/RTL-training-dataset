
module matrix_mult_mul_8bkb_Mul5S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [(-1)+8:0] a;
  input  [(-1)+8:0] b;
  output [16-1:0] p;
  reg  signed  [(-1)+8:0] a_reg0;
  reg  signed  [(-1)+8:0] b_reg0;
  wire signed  [16-1:0] tmp_product;
  reg  signed  [16-1:0] buff0;
  reg  signed  [16-1:0] buff1;
  reg  signed  [16-1:0] buff2;

  assign p = buff2;
  assign tmp_product = a_reg0*b_reg0;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            a_reg0 <= a;
            b_reg0 <= b;
            buff0 <= tmp_product;
            buff1 <= buff0;
            buff2 <= buff1;
          end
          
      end
endmodule

