
module mux_case_unbal_8_7  #(parameter  N = 8, W = 7)
  (input  [(0-1)+(W*N):0] i,
   input  [$clog2(N)-1:0] s,
   output reg [W-1:0] o);

  
  always @* 
      begin
        o <= {W{1'bx}};
        case (s)

          0: o <= i[0 +: W];

          default: case (s)

                1: o <= i[W +: W];

                1<<1: o <= i[W<<1 +: W];

                default: case (s)

                      3: o <= i[W*3 +: W];

                      4: o <= i[W*4 +: W];

                      5: o <= i[5*W +: W];

                      default: case (s)

                            6: o <= i[6*W +: W];

                            default: o <= i[7*W +: W];

                          endcase


                    endcase


              endcase


        endcase

      end
endmodule

