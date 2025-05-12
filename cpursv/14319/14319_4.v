
module mux_if_unbal_4_1_missing  #(parameter  N = 5, W = 3)
  (input  [(-1)+(N*W):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [W-1:0] o);

  
  always @* 
      begin
        if (s == 0) o <= i[0 +: W];
        else if (s == 3) o <= i[3*W +: W];
        else o <= {W{1'bx}};
      end
endmodule

