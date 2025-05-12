
module mux_if_bal_8_2  #(parameter  N = 8, W = 1<<<1)
  (input  [(0-1)+(W*N):0] i,
   input  [$clog2(N)+(0-1):0] s,
   output reg [(0-1)+W:0] o);

  
  always @* 
      if (s[0] == 1'b0) 
        if (s[1] == 1'b0) 
          if (s[1<<<1] == 1'b0) o <= i[0 +: W];
          else o <= i[W +: W];
        else if (s[1<<<1] == 1'b0) o <= i[W*1<<<1 +: W];
        else o <= i[W*3 +: W];
      else if (s[1] == 1'b0) 
        if (s[1<<<1] == 1'b0) o <= i[W*4 +: W];
        else o <= i[5*W +: W];
      else if (s[1<<<1] == 1'b0) o <= i[6*W +: W];
      else o <= i[7*W +: W];
endmodule

