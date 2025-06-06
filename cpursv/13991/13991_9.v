
module sysgen_logical_098c9fa070(input  [(0-1)+1:0] d0,
                                 input  [(0-1)+1:0] d1,
                                 output [(0-1)+1:0] y,
                                 input  clk,
                                 input  ce,
                                 input  clr);

  wire d0_1_24;
  wire d1_1_27;
  wire fully_2_1_bit;

  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign fully_2_1_bit = d0_1_24 & d1_1_27;
  assign y = fully_2_1_bit;
endmodule

