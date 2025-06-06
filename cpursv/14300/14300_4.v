
module mux_case_unbal_8_7  #(parameter  N = 8, W = 7)
  (input  [(W*N)+(0-1):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [W+(0-1):0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        case (s)

          0: o <= i[0 +: W];

          default: case (s)

                1: o <= i[W +: W];

                2: o <= i[W<<<1 +: W];

                default: case (s)

                      3: o <= i[3*W +: W];

                      4: o <= i[4*W +: W];

                      5: o <= i[5*W +: W];

                      default: case (s)

                            6: o <= i[6*W +: W];

                            default: o <= i[W*7 +: W];

                          endcase


                    endcase


              endcase


        endcase

      end
endmodule

