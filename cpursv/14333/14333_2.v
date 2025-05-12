
module mux_if_bal_5_1  #(parameter  N = 5, W = 1)
  (input  [(-1)+(N*W):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [(-1)+W:0] o);

  
  always @* 
      if (s[0] == 1'b0) 
        if (s[1] == 1'b0) 
          if (s[1<<<1] == 1'b0) o <= i[0 +: W];
          else o <= i[W +: W];
        else if (s[1<<<1] == 1'b0) o <= i[W<<1 +: W];
        else o <= i[3*W +: W];
      else o <= i[W*4 +: W];
endmodule

