
module mux_if_unbal_5_3_invert  #(parameter  N = 5, W = 3)
  (input  [(0-1)+(W*N):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [W+(0-1):0] o);

  
  always @* 
      if (s != 0) 
        if (s != 1) 
          if (s != (1+1)) 
            if (s != 3) 
              if (s != 4) o <= i[4*W +: W];
              else o <= i[0 +: W];
            else o <= i[3*W +: W];
          else o <= i[W+W +: W];
        else o <= i[W +: W];
      else o <= {W{1'bx}};
endmodule

