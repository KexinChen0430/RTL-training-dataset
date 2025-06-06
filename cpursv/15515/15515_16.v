
module nfa_accept_samples_generic_hw_mul_16ns_8ns_24_2_MAC2S_0(clk,ce,a,b,p);

  input  clk;
  input  ce;
  input  [16+(0-1):0] a;
  input  [(0-1)+8:0] b;
  output [(0-1)+24:0] p;
  reg  [(0-1)+24:0] p;
  wire [(0-1)+24:0] tmp_product;

  assign tmp_product = a*b;
  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            p <= tmp_product;
          end
          
      end
endmodule

