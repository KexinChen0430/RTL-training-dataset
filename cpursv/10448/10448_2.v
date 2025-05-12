
module add_1(input  [3:0] in,
             output [3:0] out,
             input  clk,
             input  rst);

  assign out = 1+in;
endmodule

