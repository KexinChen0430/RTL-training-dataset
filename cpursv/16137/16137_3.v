
module nfa_accept_samples_generic_hw_mul_8ns_6ns_14_2_MAC2S_1(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [8+(0-1):0] a;
  input  [6-1:0] b;
  output [(0-1)+14:0] p;
  reg  [(0-1)+14:0] p;
  wire [(0-1)+14:0] tmp_product;

  assign tmp_product = a*b;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            p <= tmp_product;
          end
          
      end
endmodule

