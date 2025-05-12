
module AL_MAP_ADDER(input  a,
                    input  b,
                    input  c,
                    output [1:0] o);

  parameter  ALUTYPE = ADD;

  
  generate
      case (ALUTYPE)

        ADD: assign o = (b+a)+c;

        SUB: assign o = (a-b)+(0-c);

        A_LE_B: assign o = (a-b)+(0-c);

        ADD_CARRY: assign o = {a,1'b0};

        SUB_CARRY: assign o = {~a,1'b0};

        A_LE_B_CARRY: assign o = {a,1'b0};

        default: assign o = (b+a)+c;

      endcase

  endgenerate

endmodule

