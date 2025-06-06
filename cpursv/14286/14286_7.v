
module mux_if_unbal_5_3_width_mismatch  #(parameter  N = 5, W = 3)
  (input  [(N*W)+(0-1):0] i,
   input  [(0-1)+$clog2(N):0] s,
   output reg [W+(0-1):0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        if (s == 0) o <= i[0 +: W];
          
        if (s == 1) o <= i[W +: W];
          
        if (s == (1+1)) o[W-(1+1):0] <= i[W+W +: W+(0-1)];
          
        if (s == 3) o <= i[W*3 +: W];
          
        if (s == 4) o <= i[4*W +: W];
          
      end
endmodule

