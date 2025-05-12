
module image_filter_mul_10ns_12ns_22_2_AM2S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [10+(-1):0] a;
  input  [12-1:0] b;
  output [(-1)+22:0] p;
  reg  signed  [(-1)+22:0] p;
  wire [(-1)+22:0] tmp_product;

  assign tmp_product = b*a;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            p <= tmp_product;
          end
          
      end
endmodule

