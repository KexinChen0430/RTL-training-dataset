
module mux_if_unbal_5_3_invert  #(parameter  N = 5, W = 3)
  (input  [(0-1)+(N*W):0] i,
   input  [$clog2(N)+(0-1):0] s,
   output reg [W-1:0] o);

  
  always @* 
      if (s != 0) 
        if (s != 1) 
          if (s != 1<<<1) 
            if (s != 3) 
              if (s != 4) o <= i[4*W +: W];
              else o <= i[0 +: W];
            else o <= i[W*3 +: W];
          else o <= i[W<<1 +: W];
        else o <= i[W +: W];
      else o <= {W{1'bx}};
endmodule

