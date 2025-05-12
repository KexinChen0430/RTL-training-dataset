
module mux_if_unbal_5_3_order  #(parameter  N = 5, W = 3)
  (input  [(0-1)+(N*W):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [(0-1)+W:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        if (s == 3) o <= i[3*W +: W];
          
        if (s == (1+1)) o <= i[W+W +: W];
          
        if (s == 1) o <= i[W +: W];
          
        if (s == 4) o <= i[W*4 +: W];
          
        if (s == 0) o <= i[0 +: W];
          
      end
endmodule

