
module input_mux  #(parameter  C_FSM_SWITCH_WIDTH = 20, C_INTERFACE = 0)
  (input  [4:0] sel,
   input  [(0-1)+C_FSM_SWITCH_WIDTH:0] in_pin,
   output reg out_int);

  
  generate
      case (C_INTERFACE)

        0: begin : ARDUINO
              
              always @(sel or in_pin)
                  case (sel)

                    5'h00: out_int = in_pin[0];

                    default: out_int = 1'b0;

                  endcase

            end

        1: begin : RASPBERRYPI
              
              always @(sel or in_pin)
                  case (sel)

                    default: out_int = 1'b0;

                  endcase

            end

        default: begin : ARDUINO
              
              always @(sel or in_pin)
                  case (sel)

                    default: out_int = 1'b0;

                  endcase

            end

      endcase

  endgenerate

endmodule

