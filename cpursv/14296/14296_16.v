
module mux_if_unbal_4_1  #(parameter  N = 4, W = 1)
  (input  [(N*W)-1:0] i,
   input  [(0-1)+$clog2(N):0] s,
   output reg [W-1:0] o);

  
  always @* 
      if (s == 0) o <= i[0 +: W];
      else if (s == 1) o <= i[W +: W];
      else if (s == 1<<1) o <= i[W<<1 +: W];
      else if (s == 3) o <= i[3*W +: W];
      else o <= {W{1'bx}};
endmodule

