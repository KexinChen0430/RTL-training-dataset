
module mux_if_unbal_5_3_nonexcl  #(parameter  N = 5, W = 3)
  (input  [(-1)+(W*N):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [W-1:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        if (s == 0) o <= i[0 +: W];
          
        if (s == 1) o <= i[W +: W];
          
        if (s == (1+1)) o <= i[W*(1+1) +: W];
          
        if (s == 3) o <= i[3*W +: W];
          
        if (s == 4) o <= i[4*W +: W];
          
        if (s == 0) o <= i[W*(1+1) +: W];
          
      end
endmodule

