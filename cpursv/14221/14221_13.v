
module mux_if_unbal_5_3_invert  #(parameter  N = 5, W = 3)
  (input  [(-1)+(W*N):0] i,
   input  [(-1)+$clog2(N):0] s,
   output reg [W-1:0] o);

  
  always @* 
      if (s != 0) 
        if (s != 1) 
          if (s != 2) 
            if (s != 3) 
              if (s != 4) o <= i[W*4 +: W];
              else o <= i[0 +: W];
            else o <= i[3*W +: W];
          else o <= i[2*W +: W];
        else o <= i[W +: W];
      else o <= {W{1'bx}};
endmodule

