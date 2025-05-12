
module image_filter_mul_10ns_12ns_22_2_AM2S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [(-1)+10:0] a;
  input  [(-1)+12:0] b;
  output [22-1:0] p;
  reg  signed  [22-1:0] p;
  wire [22-1:0] tmp_product;

  assign tmp_product = a*b;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            p <= tmp_product;
          end
          
      end
endmodule

