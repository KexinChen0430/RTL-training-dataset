
module logical_28d385d867(input  [(-1)+1:0] d0,
                          input  [(-1)+1:0] d1,
                          output [(-1)+1:0] y,
                          input  clk,
                          input  ce,
                          input  clr);

  wire d0_1_24;
  wire d1_1_27;
  wire fully_2_1_bit;

  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign fully_2_1_bit = d1_1_27 & d0_1_24;
  assign y = fully_2_1_bit;
endmodule

