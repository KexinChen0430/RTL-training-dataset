
module dut(output wire [2:0] value);

  parameter  select = 0;

  case (select)

    0: assign value = 3'b000;

    1: assign value = 3'b001;

    2: assign value = 3'b010;

    3: assign value = 3'b011;

    default: assign value = 3'b111;

  endcase

endmodule

