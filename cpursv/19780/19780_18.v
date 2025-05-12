
module AL_MAP_ADDER(input  a,
                    input  b,
                    input  c,
                    output [1:0] o);

  parameter  ALUTYPE = ADD;

  
  generate
      case (ALUTYPE)

        ADD: assign o = a+(c+b);

        SUB: assign o = (-b)+(a+(-c));

        A_LE_B: assign o = (-b)+(a+(-c));

        ADD_CARRY: assign o = {a,1'b0};

        SUB_CARRY: assign o = {~a,1'b0};

        A_LE_B_CARRY: assign o = {a,1'b0};

        default: assign o = a+(c+b);

      endcase

  endgenerate

endmodule

