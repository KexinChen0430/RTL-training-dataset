
module mux_case_unbal_8_7  #(parameter  N = 8, W = 7)
  (input  [(N*W)+(0-1):0] i,
   input  [(0-1)+$clog2(N):0] s,
   output reg [(0-1)+W:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        case (s)

          0: o <= i[0 +: W];

          default: case (s)

                1: o <= i[W +: W];

                1+1: o <= i[W+W +: W];

                default: case (s)

                      3: o <= i[3*W +: W];

                      4: o <= i[W*4 +: W];

                      5: o <= i[5*W +: W];

                      default: case (s)

                            6: o <= i[W*6 +: W];

                            default: o <= i[7*W +: W];

                          endcase


                    endcase


              endcase


        endcase

      end
endmodule

