
module mux_if_bal_8_2  #(parameter  N = 8, W = 2)
  (input  [(N*W)-1:0] i,
   input  [$clog2(N)+(0-1):0] s,
   output reg [W+(0-1):0] o);

  
  always @* 
      if (s[0] == 1'b0) 
        if (s[1] == 1'b0) 
          if (s[2] == 1'b0) o <= i[0 +: W];
          else o <= i[W +: W];
        else if (s[2] == 1'b0) o <= i[W<<<1 +: W];
        else o <= i[W*3 +: W];
      else if (s[1] == 1'b0) 
        if (s[2] == 1'b0) o <= i[4*W +: W];
        else o <= i[5*W +: W];
      else if (s[2] == 1'b0) o <= i[W*6 +: W];
      else o <= i[7*W +: W];
endmodule

