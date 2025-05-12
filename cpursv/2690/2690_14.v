
module simple_combinational(input  wire i_A,
                            input  wire i_B,
                            output wire o_A,
                            output wire o_B);

  assign o_A = i_A ^ i_B;
  assign o_B_internal = i_B & i_A;
  assign o_B_outsideo = i_B & i_A;
  wire  o_B_internal = 1'h0;

  wire  o_B_outsideo = 1'h0;

endmodule

