
module mux_if_unbal_5_3  #(parameter  N = 5, W = 3)
  (input  [(N*W)-1:0] i,
   input  [(-1)+$clog2(N):0] s,
   output reg [W-1:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        if (s == 0) o <= i[0 +: W];
          
        if (s == 1) o <= i[W +: W];
          
        if (s == 1<<<1) o <= i[W*1<<<1 +: W];
          
        if (s == 3) o <= i[3*W +: W];
          
        if (s == 4) o <= i[W*4 +: W];
          
      end
endmodule

