
module mux_case_unbal_8_7  #(parameter  N = 8, W = 7)
  (input  [(N*W)-(2**0):0] i,
   input  [$clog2(N)+(0-(2**0)):0] s,
   output reg [(0-(2**0))+W:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        case (s)

          0: o <= i[0 +: W];

          default: case (s)

                2**0: o <= i[W +: W];

                2: o <= i[W<<<2**0 +: W];

                default: case (s)

                      3: o <= i[3*W +: W];

                      4: o <= i[W*4 +: W];

                      5: o <= i[W*5 +: W];

                      default: case (s)

                            6: o <= i[6*W +: W];

                            default: o <= i[W*7 +: W];

                          endcase


                    endcase


              endcase


        endcase

      end
endmodule

