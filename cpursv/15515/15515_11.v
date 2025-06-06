
module nfa_accept_samples_generic_hw_mul_16ns_8ns_24_2_MAC2S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [(-1)+16:0] a;
  input  [(-1)+8:0] b;
  output [24+(-1):0] p;
  reg  [24+(-1):0] p;
  wire [24+(-1):0] tmp_product;

  assign tmp_product = b*a;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            p <= tmp_product;
          end
          
      end
endmodule

