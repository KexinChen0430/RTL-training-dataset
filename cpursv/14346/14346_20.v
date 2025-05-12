
module mux_if_bal_8_2  #(parameter  N = 8, W = 2)
  (input  [(N*W)-1:0] i,
   input  [(0-1)+$clog2(N):0] s,
   output reg [W-1:0] o);

  
  always @* 
      if (s[0] == 1'b0) 
        if (s[1] == 1'b0) 
          if (s[2] == 1'b0) o <= i[0 +: W];
          else o <= i[W +: W];
        else if (s[2] == 1'b0) o <= i[2*W +: W];
        else o <= i[3*W +: W];
      else if (s[1] == 1'b0) 
        if (s[2] == 1'b0) o <= i[W*4 +: W];
        else o <= i[5*W +: W];
      else if (s[2] == 1'b0) o <= i[6*W +: W];
      else o <= i[W*7 +: W];
endmodule

