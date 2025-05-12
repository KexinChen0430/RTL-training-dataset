
module mux_if_unbal_4_1_nonexcl  #(parameter  N = 4, W = 1)
  (input  [(W*N)-1:0] i,
   input  [$clog2(N)+(0-1):0] s,
   output reg [W+(0-1):0] o);

  
  always @* 
      if (s == 0) o <= i[0 +: W];
      else if (s == 1) o <= i[W +: W];
      else if (s == 1<<<1) o <= i[W+W +: W];
      else if (s == 3) o <= i[3*W +: W];
      else if (s == 0) o <= {W{1'b0}};
      else o <= {W{1'bx}};
endmodule

