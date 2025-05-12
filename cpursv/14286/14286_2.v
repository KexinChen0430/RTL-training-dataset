
module mux_if_unbal_5_3_width_mismatch  #(parameter  N = 5, W = 3)
  (input  [(W*N)+(-1):0] i,
   input  [(-1)+$clog2(N):0] s,
   output reg [W-1:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        if (s == 0) o <= i[0 +: W];
          
        if (s == 1) o <= i[W +: W];
          
        if (s == 2) o[W+(0-2):0] <= i[2*W +: W-1];
          
        if (s == 3) o <= i[W*3 +: W];
          
        if (s == 4) o <= i[4*W +: W];
          
      end
endmodule

