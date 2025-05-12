
module mux_if_bal_5_1  #(parameter  N = 5, W = 1)
  (input  [(0-1)+(W*N):0] i,
   input  [(0-1)+$clog2(N):0] s,
   output reg [(0-1)+W:0] o);

  
  always @* 
      if (s[0] == 1'b0) 
        if (s[1] == 1'b0) 
          if (s[1<<1] == 1'b0) o <= i[0 +: W];
          else o <= i[W +: W];
        else if (s[1<<1] == 1'b0) o <= i[1<<1*W +: W];
        else o <= i[W*3 +: W];
      else o <= i[4*W +: W];
endmodule

